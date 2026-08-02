import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../core/network/api_client.dart';
import '../../../core/theme/app_colors.dart';
import '../bloc/product_bloc.dart';
import '../data/product_repository.dart';
import '../models/product_filter_model.dart';
import 'widgets/product_grid_empty_widget.dart';
import 'widgets/product_grid_error_widget.dart';
import 'widgets/product_mason_grid_item.dart';

class ProductGridScreen extends StatefulWidget {
  const ProductGridScreen({super.key});

  @override
  State<ProductGridScreen> createState() => _ProductGridScreenState();
}

class _ProductGridScreenState extends State<ProductGridScreen> {
  late final ProductBloc _productBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _productBloc = ProductBloc(
      repository: ProductRepository(dio: context.read<ApiClient>().dio),
    )..add(LoadProducts(ProductFilterModel()));

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      _productBloc.add(const LoadMoreProducts());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _productBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return BlocProvider.value(
      value: _productBloc,
      child: Scaffold(
        backgroundColor: colors.surface,
        body: SafeArea(
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return const Center(child: CircularProgressIndicator());
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

                return RefreshIndicator(
                  onRefresh: () async {
                    _productBloc.add(const RefreshProducts());
                    await Future.delayed(const Duration(milliseconds: 500));
                  },
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.all(8),
                        sliver: SliverMasonryGrid.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          itemBuilder: (context, index) {
                            final product = state.products[index];
                            return ProductMasonGridItem(product: product);
                          },
                          childCount: state.products.length,
                        ),
                      ),
                      if (state.isLoadingMore)
                        const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}