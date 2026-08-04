import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/bloc/main_bloc.dart';
import 'package:mobile/features/products/bloc/product_detail_bloc.dart';
import 'package:mobile/features/products/models/product_detail_model.dart';
import 'package:mobile/features/products/models/product_model.dart';

import '../../../core/theme/app_colors.dart';
import '../../../generated/l10n.dart';
import 'widgets/product_detail_bottom_bar_widget.dart';
import 'widgets/product_detail_gallery_widget.dart';
import 'widgets/product_detail_price_widget.dart';
import 'widgets/product_detail_shipping_widget.dart';
import 'widgets/product_detail_variant_widget.dart';
import 'widgets/product_detail_trust_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import 'widgets/product_quantity_sheet_widget.dart';
import '../../../core/network/api_client.dart';
import 'widgets/product_detail_comments_widget.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.model});
  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final localization = S.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          if (state is ProductDetailInitial ||
              state is GetProductDetailProgress) {
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
                      color: colors.error,
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

class _ProductDetailBody extends StatelessWidget {
  const _ProductDetailBody({required this.detail});

  final ProductDetailModel detail;

  @override
  Widget build(BuildContext context) {
    final locale = context.select((MainBloc bloc) => bloc.state.locale);
    final name = detail.localizedName(locale);
    final description = detail.localizedDescription(locale);

    final images = detail.gallery.isNotEmpty
        ? detail.gallery
            .map((g) => g.media?.fullUrl)
            .whereType<String>()
            .toList()
        : [
            if (detail.thumbnailMedia?.fullUrl != null)
              detail.thumbnailMedia!.fullUrl,
          ];

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
              ProductDetailGalleryWidget(
                  images: images,
                  onSharePressed: () {
                    SharePlus.instance.share(
                      ShareParams(
                        text:
                            '$name\n${detail.salePrice.toStringAsFixed(2)} ${detail.currency?.code ?? ''}',
                      ),
                    );
                  },
                ),
                ProductDetailPriceWidget(
                  name: name,
                  brandName: detail.brand?.name,
                  salePrice: detail.salePrice,
                  costPrice: detail.costPrice,
                  currencyCode: detail.currency?.code ?? '',
                  rating: detail.rating,
                  soldCount: detail.countOrder,
                ),
                if (detail.variations.isNotEmpty) ...[
                  ProductDetailVariantWidget(variations: detail.variations),
                  const SizedBox(height: 8),
                ],
               Divider(height: 1, color: Theme.of(context).dividerColor),
                const ProductDetailShippingWidget(),
                const ProductDetailTrustWidget(),
               if (description.isNotEmpty) ...[
                  Divider(height: 1, color: Theme.of(context).dividerColor),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      description,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(height: 1.5),
                    ),
                  ),
                ],
                Divider(height: 1, color: Theme.of(context).dividerColor),
                ProductDetailCommentsWidget(
                  productId: detail.id,
                  rating: detail.rating,
                  reviewCount: detail.countOrder,
                  apiClient: context.read<ApiClient>(),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        ProductDetailBottomBarWidget(
          onAddToCart: () {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (_) => ProductQuantitySheetWidget(
                price: detail.salePrice,
                currencyCode: detail.currency?.code ?? '',
              ),
            );
          },
          onBuyNow: () => context.push(AppRoutes.addAddress),
        ),
      ],
    );
  }
}