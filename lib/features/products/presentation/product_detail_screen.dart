import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/bloc/main_bloc.dart';
import 'package:mobile/features/favorite/presentation/widgets/favorite_icon.dart';
import 'package:mobile/features/products/bloc/product_detail_bloc.dart';
import 'package:mobile/features/products/models/product_detail_model.dart';
import 'package:mobile/features/products/models/product_model.dart';

import '../../../generated/l10n.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.model});
  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    final localization = S.of(context);

    return Scaffold(
      body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          if (state is ProductDetailInitial || state is GetProductDetailProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GetProductDetailError) {
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
                      onPressed: () => context.read<ProductDetailBloc>().add(
                        GetProductDetailEvent(productId: model.id),
                      ),
                      child: Text(localization.retry),
                    ),
                  ],
                ),
              ),
            );
          }

          final detail = (state as GetProductDetailSuccess).productDetailModel;
          return _ProductDetailBody(detail: detail);
        },
      ),
    );
  }
}

class _ProductDetailBody extends StatefulWidget {
  const _ProductDetailBody({required this.detail});
  final ProductDetailModel detail;

  @override
  State<_ProductDetailBody> createState() => _ProductDetailBodyState();
}

class _ProductDetailBodyState extends State<_ProductDetailBody> {
  final _galleryController = PageController();
  int _galleryIndex = 0;

  @override
  void dispose() {
    _galleryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final detail = widget.detail;
    final locale = context.select((MainBloc bloc) => bloc.state.locale);
    final name = detail.localizedName(locale);
    final description = detail.localizedDescription(locale);
    final hasDiscount = detail.costPrice > detail.salePrice;

    final images = detail.gallery.isNotEmpty
        ? detail.gallery.map((g) => g.media?.fullUrl).whereType<String>().toList()
        : [if (detail.thumbnailMedia?.fullUrl != null) detail.thumbnailMedia!.fullUrl];

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 320,
          flexibleSpace: FlexibleSpaceBar(
            background: images.isEmpty
                ? Container(color: colors.surfaceContainerHighest)
                : Stack(
                    fit: StackFit.expand,
                    children: [
                      PageView.builder(
                        controller: _galleryController,
                        itemCount: images.length,
                        onPageChanged: (index) =>
                            setState(() => _galleryIndex = index),
                        itemBuilder: (context, index) => CachedNetworkImage(
                          imageUrl: images[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                      if (images.length > 1)
                        Positioned(
                          bottom: 12,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(images.length, (index) {
                              final isActive = index == _galleryIndex;
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 3,
                                ),
                                width: isActive ? 18 : 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? Colors.white
                                      : Colors.white.withValues(alpha: 0.5),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              );
                            }),
                          ),
                        ),
                    ],
                  ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    FavoriteIconWidget(
                      productModel: ProductModel.fromDetail(detail),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '${detail.salePrice.toStringAsFixed(0)} ${detail.currency?.code ?? ''}',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: colors.error,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    if (hasDiscount) ...[
                      const SizedBox(width: 8),
                      Text(
                        detail.costPrice.toStringAsFixed(0),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colors.onSurfaceVariant,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),
                if (detail.brand != null) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.storefront_outlined,
                        size: 16,
                        color: colors.onSurfaceVariant,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        detail.brand!.name,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
                if (detail.variations.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: detail.variations
                        .where((v) => v.color != null)
                        .map(
                          (v) => Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: v.color!.swatch,
                              shape: BoxShape.circle,
                              border: Border.all(color: colors.outlineVariant),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
                if (description.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  Text(
                    description,
                    style: theme.textTheme.bodyMedium?.copyWith(height: 1.4),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
