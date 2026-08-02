import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mobile/features/products/data/product_repository.dart';
import 'package:mobile/features/products/models/product_detail_model.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductRepository productRepository;

  ProductDetailBloc({required this.productRepository})
    : super(ProductDetailInitial()) {
    on<GetProductDetailEvent>(_onLoadProductDetail);
  }

  Future<void> _onLoadProductDetail(
    GetProductDetailEvent event,
    Emitter<ProductDetailState> emit,
  ) async {
    try {
      emit(GetProductDetailProgress());
      final result = await productRepository.getProductDetail(
        event.productId,
      );
      emit(GetProductDetailSuccess(productDetailModel: result));
    } catch (e) {
      emit(GetProductDetailError(errorMessage: e.toString()));
    }
  }
}
