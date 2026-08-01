import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/features/products/models/product_filter_model.dart';
import 'package:mobile/features/products/models/product_model.dart';

import '../data/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  CancelToken _cancelToken = CancelToken();

  ProductBloc({required this.repository}) : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<LoadMoreProducts>(_onLoadMoreProducts);
    on<RefreshProducts>(_onRefreshProducts);
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductState> emit,
  ) async {
    _cancelToken.cancel();
    _cancelToken = CancelToken();

    emit(ProductLoading());

    try {
      final filter = event.filter.resetPage();
      final response = await repository.getProducts(
        filter,
        cancelToken: _cancelToken,
      );

      emit(
        ProductLoaded(
          products: response.products,
          hasMore: response.meta.hasNextPage,
          filter: filter,
        ),
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) return;
      emit(ProductError(message: _errorMessage(e), filter: event.filter));
    } catch (e) {
      emit(ProductError(message: e.toString(), filter: event.filter));
    }
  }

  Future<void> _onLoadMoreProducts(
    LoadMoreProducts event,
    Emitter<ProductState> emit,
  ) async {
    final current = state;
    if (current is! ProductLoaded ||
        !current.hasMore ||
        current.isLoadingMore) {
      return;
    }

    emit(current.copyWith(isLoadingMore: true));

    try {
      final nextFilter = current.filter.copyWith(page: current.filter.page + 1);
      final response = await repository.getProducts(
        nextFilter,
        cancelToken: _cancelToken,
      );

      emit(
        current.copyWith(
          products: [...current.products, ...response.products],
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

  Future<void> _onRefreshProducts(
    RefreshProducts event,
    Emitter<ProductState> emit,
  ) async {
    final current = state;
    final filter = current is ProductLoaded
        ? current.filter.resetPage()
        : ProductFilterModel();

    add(LoadProducts(filter));
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
