import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/features/banners/model/banner_filter_model.dart';
import 'package:mobile/features/banners/model/banner_model.dart';

import '../data/banners_repository.dart';

part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final BannersRepository bannersRepository;
  CancelToken _cancelToken = CancelToken();

  BannerBloc({required this.bannersRepository}) : super(BannerInitial()) {
    on<LoadBanners>(_onLoadBanners);
    on<RefreshBanners>(_onRefreshBanners);
  }

  Future<void> _onLoadBanners(
    LoadBanners event,
    Emitter<BannerState> emit,
  ) async {
    _cancelToken.cancel();
    _cancelToken = CancelToken();
    emit(BannerLoading());

    try {
      final response = await bannersRepository.loadBanners(
        event.filter,
        cancelToken: _cancelToken,
      );

      final banners = response.banners.where((b) => b.isCurrentlyActive).toList()
        ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));

      emit(BannerLoaded(banners: banners, filter: event.filter));
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) return;
      emit(BannerError(message: _errorMessage(e), filter: event.filter));
    } catch (e) {
      emit(BannerError(message: e.toString(), filter: event.filter));
    }
  }

  FutureOr<void> _onRefreshBanners(
    RefreshBanners event,
    Emitter<BannerState> emit,
  ) {
    final current = state;
    final filter = current is BannerLoaded
        ? current.filter
        : BannerFilterModel();

    add(LoadBanners(filter));
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
