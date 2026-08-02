part of 'viewed_products_bloc.dart';

sealed class ViewedProductsState extends Equatable {
  const ViewedProductsState();

  @override
  List<Object> get props => [];
}

final class ViewedProductsInitial extends ViewedProductsState {}

final class ViewedProductsLoading extends ViewedProductsState {}

final class ViewedProductsLoaded extends ViewedProductsState {
  final List<ProductModel> products;

  const ViewedProductsLoaded({required this.products});

  @override
  List<Object> get props => [products];
}

final class ViewedProductsError extends ViewedProductsState {
  final String message;

  const ViewedProductsError({required this.message});

  @override
  List<Object> get props => [message];
}
