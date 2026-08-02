import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/features/favorite/model/favorite_filter_model.dart';
import 'package:mobile/features/favorite/model/favorite_model.dart';

import '../data/favorite_repository.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteRepository favoriteRepository;
  CancelToken _cancelToken = CancelToken();

  FavoriteBloc({required this.favoriteRepository}) : super(FavoriteInitial()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<RefreshFavorites>(_onRefreshFavorites);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  bool isFavorite(int productId) {
    final current = state;
    return current is FavoriteLoaded && current.isFavorite(productId);
  }

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<FavoriteState> emit,
  ) async {
    _cancelToken.cancel();
    _cancelToken = CancelToken();
    emit(FavoriteLoading());

    try {
      final response = await favoriteRepository.loadFavorites(
        filterModel: event.filter,
        cancelToken: _cancelToken,
      );
      emit(FavoriteLoaded(favorites: response.favorites, filter: event.filter));
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) return;
      emit(FavoriteError(message: _errorMessage(e), filter: event.filter));
    } catch (e) {
      emit(FavoriteError(message: e.toString(), filter: event.filter));
    }
  }

  void _onRefreshFavorites(RefreshFavorites event, Emitter<FavoriteState> emit) {
    final current = state;
    final filter = switch (current) {
      FavoriteLoaded(:final filter) => filter,
      FavoriteError(:final filter) => filter,
      _ => const FavoriteFilterModel(),
    };

    add(LoadFavorites(filter));
  }

  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<FavoriteState> emit,
  ) async {
    final current = state;
    if (current is! FavoriteLoaded) return;

    final existing = current.favoriteFor(event.productId);

    if (existing != null) {
      emit(
        current.copyWith(
          favorites: current.favorites
              .where((favorite) => favorite.id != existing.id)
              .toList(),
        ),
      );
      try {
        await favoriteRepository.removeFavorite(existing.id);
      } catch (_) {
        emit(current);
      }
      return;
    }

    final placeholder = FavoriteModel(
      id: -event.productId,
      userId: 0,
      productId: event.productId,
      createdAt: DateTime.now(),
    );
    emit(
      current.copyWith(favorites: [...current.favorites, placeholder]),
    );

    try {
      final created = await favoriteRepository.addFavorite(event.productId);
      final latest = state;
      if (latest is FavoriteLoaded) {
        emit(
          latest.copyWith(
            favorites: latest.favorites
                .map((favorite) => favorite.id == placeholder.id ? created : favorite)
                .toList(),
          ),
        );
      }
    } catch (_) {
      emit(current);
    }
  }

  String _errorMessage(DioException e) {
    return switch (e.type) {
      DioExceptionType.connectionError => 'Нет подключения к интернету',
      DioExceptionType.connectionTimeout ||
      DioExceptionType.receiveTimeout => 'Превышено время ожидания',
      _ => e.response?.statusMessage ?? 'Ошибка загрузки',
    };
  }

  @override
  Future<void> close() {
    _cancelToken.cancel();
    return super.close();
  }
}
