import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/theme/app_colors.dart';
import '../../bloc/product_bloc.dart';
import '../../data/product_repository.dart';
import '../../models/product_filter_model.dart';
import 'product_grid_empty_widget.dart';
import 'product_grid_error_widget.dart';
import 'product_mason_grid_item.dart';

class ProductPersonGridWidget extends StatefulWidget {
  const ProductPersonGridWidget({super.key});

  @override
  State<ProductPersonGridWidget> createState() =>
      _ProductPersonGridWidgetState();
}

class _ProductPersonGridWidgetState extends State<ProductPersonGridWidget> {
  late final ProductBloc _productBloc;

  @override
  void initState() {
    super.initState();
    _productBloc = ProductBloc(
      repository: ProductRepository(dio: context.read<ApiClient>().dio),
    )..add(LoadProducts(ProductFilterModel()));
  }

  @override
  void dispose() {
    _productBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return BlocProvider.value(
      value: _productBloc,
      child: Container(
        color: colors.background,
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading || state is ProductInitial) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            if (state is ProductError) {
              return ProductGridErrorWidget(
                onRetry: () => _productBloc.add(
                  LoadProducts(state.filter ?? ProductFilterModel()),
                ),
              );
            }

            if (state is ProductLoaded) {
              if (state.products.isEmpty) {
                return const ProductGridEmptyWidget();
              }

              return MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return ProductMasonGridItem(product: product);
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}