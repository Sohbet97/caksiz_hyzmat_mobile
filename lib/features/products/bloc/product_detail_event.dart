part of 'product_detail_bloc.dart';

@immutable
sealed class ProductDetailEvent extends Equatable {}

final class GetProductDetailEvent extends ProductDetailEvent {
  final int productId;

  GetProductDetailEvent({required this.productId});

  @override
  List<Object?> get props => [productId];
}
