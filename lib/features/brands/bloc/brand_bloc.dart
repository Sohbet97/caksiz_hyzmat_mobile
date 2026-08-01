import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/features/brands/data/brands_repository.dart';
import 'package:mobile/features/brands/model/brand_filter_model.dart';
import 'package:mobile/features/brands/model/brand_model.dart';

part 'brand_event.dart';
part 'brand_state.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  final BrandsRepository brandsRepository;
  CancelToken _cancelToken = CancelToken();

  BrandBloc({required this.brandsRepository}) : super(BrandInitial()) {
    on<LoadBrands>(_onLoadBrands);
    on<LoadMoreBrands>(_onLoadMoreBrands);
    on<RefreshBrands>(_onRefreshBrands);
  }

  Future<void> _onLoadBrands(LoadBrands event, Emitter<BrandState> emit) async {
    _cancelToken.cancel();
    _cancelToken = CancelToken();
    emit(BrandLoading());

    try {
      final filter = event.filter.resetPage();
      final response = await brandsRepository.loadBrands(
        filter,
        cancelToken: _cancelToken,
      );

      emit(
        BrandLoaded(
          brands: response.brands,
          hasMore: response.meta.hasNextPage,
          filter: filter,
        ),
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) return;
      emit(BrandError(message: _errorMessage(e), filter: event.filter));
    } catch (e) {
      emit(BrandError(message: e.toString(), filter: event.filter));
    }
  }

  Future<void> _onLoadMoreBrands(
    LoadMoreBrands event,
    Emitter<BrandState> emit,
  ) async {
    final current = state;
    if (current is! BrandLoaded || !current.hasMore || current.isLoadingMore) {
      return;
    }

    emit(current.copyWith(isLoadingMore: true));

    try {
      final nextFilter = current.filter.copyWith(page: current.filter.page + 1);
      final response = await brandsRepository.loadBrands(
        nextFilter,
        cancelToken: _cancelToken,
      );

      emit(
        current.copyWith(
          brands: [...current.brands, ...response.brands],
          hasMore: response.meta.hasNextPage,
          isLoadingMore: false,
          filter: nextFilter,
        ),
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) return;
      emit(current.copyWith(isLoadingMore: false));
    } catch (_) {
      emit(current.copyWith(isLoadingMore: false));
    }
  }

  FutureOr<void> _onRefreshBrands(RefreshBrands event, Emitter<BrandState> emit) {
    final current = state;
    final filter = current is BrandLoaded
        ? current.filter.resetPage()
        : BrandFilterModel();

    add(LoadBrands(filter));
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
