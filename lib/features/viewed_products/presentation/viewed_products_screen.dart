import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mobile/features/products/presentation/widgets/product_card.dart';
import 'package:mobile/features/viewed_products/bloc/viewed_products_bloc.dart';

import '../../../generated/l10n.dart';

class ViewedProductsScreen extends StatefulWidget {
  const ViewedProductsScreen({super.key});

  @override
  State<ViewedProductsScreen> createState() => _ViewedProductsScreenState();
}

class _ViewedProductsScreenState extends State<ViewedProductsScreen> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<ViewedProductsBloc>();
    if (bloc.state is ViewedProductsInitial) {
      bloc.add(const LoadViewedProducts());
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = S.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Gorenlerim')),
      body: BlocBuilder<ViewedProductsBloc, ViewedProductsState>(
        builder: (context, state) {
          if (state is ViewedProductsInitial || state is ViewedProductsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ViewedProductsError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Theme.of(context).colorScheme.error,
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    Text(localization.nasazlyk_yuze_cykdy),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => context.read<ViewedProductsBloc>().add(
                        const LoadViewedProducts(),
                      ),
                      child: Text(localization.retry),
                    ),
                  ],
                ),
              ),
            );
          }

          final products = (state as ViewedProductsLoaded).products;
          if (products.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.visibility_outlined,
                      size: 40,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 12),
                    Text(localization.categoriesEmpty),
                  ],
                ),
              ),
            );
          }

          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverMasonryGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childCount: products.length,
                  itemBuilder: (context, index) =>
                      ProductCardWidget(product: products[index]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
