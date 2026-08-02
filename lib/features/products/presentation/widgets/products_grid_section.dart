import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mobile/features/products/bloc/product_bloc.dart';
import 'package:mobile/features/products/data/product_repository.dart';
import 'package:mobile/features/products/models/product_filter_model.dart';
import 'package:mobile/features/products/presentation/widgets/product_card.dart';
import 'package:mobile/features/products/presentation/widgets/products_masonry_shimmer.dart';

import '../../../../generated/l10n.dart';

/// Универсальная секция товаров: сама владеет своим [ProductBloc],
/// пагинацией и скроллом. Можно переиспользовать на разных экранах,
/// передавая только [filter] (например brandId/categoryId/search).
///
/// [leadingSlivers] — слайверы, которые нужно показать над сеткой товаров
/// в том же скролле (баннеры, меню и т.п., как на главной).
class ProductsGridSection extends StatefulWidget {
  const ProductsGridSection({
    super.key,
    required this.filter,
    this.leadingSlivers = const [],
  });

  final ProductFilterModel filter;
  final List<Widget> leadingSlivers;

  @override
  State<ProductsGridSection> createState() => _ProductsGridSectionState();
}

class _ProductsGridSectionState extends State<ProductsGridSection>
    with AutomaticKeepAliveClientMixin {
  final _scrollController = ScrollController();
  late final ProductBloc _bloc;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _bloc = ProductBloc(repository: context.read<ProductRepository>())
      ..add(LoadProducts(widget.filter));
    _scrollController.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(covariant ProductsGridSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.filter != oldWidget.filter) {
      _bloc.add(LoadProducts(widget.filter));
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _bloc.close();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      _bloc.add(const LoadMoreProducts());
    }
  }

  Future<void> _onRefresh() {
    _bloc.add(const RefreshProducts());
    return _bloc.stream.firstWhere(
      (state) => state is ProductLoaded || state is ProductError,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          ...widget.leadingSlivers,
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: BlocBuilder<ProductBloc, ProductState>(
              bloc: _bloc,
              builder: (context, state) {
                if (state is ProductInitial || state is ProductLoading) {
                  return const ProductsMasonryShimmer();
                }

                if (state is ProductError) {
                  return _ProductsErrorSliver(
                    message: state.message,
                    onRetry: () => _bloc.add(
                      LoadProducts(state.filter ?? widget.filter),
                    ),
                  );
                }

                final loaded = state as ProductLoaded;
                if (loaded.products.isEmpty) {
                  return const SliverToBoxAdapter(child: SizedBox.shrink());
                }

                return SliverMasonryGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childCount: loaded.products.length,
                  itemBuilder: (context, index) =>
                      ProductCardWidget(product: loaded.products[index]),
                );
              },
            ),
          ),
          BlocBuilder<ProductBloc, ProductState>(
            bloc: _bloc,
            builder: (context, state) {
              final isLoadingMore = state is ProductLoaded && state.isLoadingMore;
              if (!isLoadingMore) {
                return const SliverToBoxAdapter(child: SizedBox());
              }

              return const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: CircularProgressIndicator()),
                ),
              );
            },
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
        ],
      ),
    );
  }
}

class _ProductsErrorSliver extends StatelessWidget {
  const _ProductsErrorSliver({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final localization = S.of(context);
    final colors = Theme.of(context).colorScheme;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          children: [
            Icon(Icons.error_outline, color: colors.error, size: 28),
            const SizedBox(height: 8),
            Text(message),
            const SizedBox(height: 8),
            TextButton(onPressed: onRetry, child: Text(localization.retry)),
          ],
        ),
      ),
    );
  }
}
