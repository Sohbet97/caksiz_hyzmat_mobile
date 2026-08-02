part of 'product_detail_bloc.dart';

@immutable
sealed class ProductDetailState extends Equatable {}

final class ProductDetailInitial extends ProductDetailState {
  @override
  List<Object?> get props => [];
}

final class GetProductDetailProgress extends ProductDetailState {
  @override
  List<Object?> get props => [];
}

final class GetProductDetailSuccess extends ProductDetailState {
  final ProductDetailModel productDetailModel;

  GetProductDetailSuccess({required this.productDetailModel});

  @override
  List<Object?> get props => [productDetailModel];
}

final class GetProductDetailError extends ProductDetailState {
  final String errorMessage;

  GetProductDetailError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
