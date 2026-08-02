part of 'viewed_products_bloc.dart';

sealed class ViewedProductsEvent extends Equatable {
  const ViewedProductsEvent();

  @override
  List<Object> get props => [];
}

final class LoadViewedProducts extends ViewedProductsEvent {
  const LoadViewedProducts();
}
