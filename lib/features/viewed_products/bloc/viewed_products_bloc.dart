import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/features/products/data/product_repository.dart';
import 'package:mobile/features/products/models/product_model.dart';
import 'package:mobile/features/viewed_products/data/viewed_products_repository.dart';

part 'viewed_products_event.dart';
part 'viewed_products_state.dart';

class ViewedProductsBloc
    extends Bloc<ViewedProductsEvent, ViewedProductsState> {
  final ViewedProductsRepository viewedProductsRepository;
  final ProductRepository productRepository;

  ViewedProductsBloc({
    required this.viewedProductsRepository,
    required this.productRepository,
  }) : super(ViewedProductsInitial()) {
    on<LoadViewedProducts>(_onLoadViewedProducts);
  }

  Future<void> _onLoadViewedProducts(
    LoadViewedProducts event,
    Emitter<ViewedProductsState> emit,
  ) async {
    emit(ViewedProductsLoading());

    try {
      final ids = await viewedProductsRepository.getViewedProductIds();

      final products = <ProductModel>[];
      for (final id in ids) {
        try {
          final detail = await productRepository.getProductDetail(id);
          products.add(ProductModel.fromDetail(detail));
        } catch (_) {
          // Товар мог быть удалён/скрыт — просто пропускаем его в истории.
        }
      }

      emit(ViewedProductsLoaded(products: products));
    } catch (e) {
      emit(ViewedProductsError(message: e.toString()));
    }
  }
}
