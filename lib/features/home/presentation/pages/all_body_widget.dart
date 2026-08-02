import 'package:flutter/material.dart';
import 'package:mobile/features/banners/presentation/widgets/banners_carousel.dart';
import 'package:mobile/features/home/presentation/widgets/home_menu_widget.dart';
import 'package:mobile/features/products/models/product_filter_model.dart';
import 'package:mobile/features/products/presentation/widgets/products_grid_section.dart';

class AllBodyWidget extends StatelessWidget {
  const AllBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ProductsGridSection(
        filter: const ProductFilterModel(),
        leadingSlivers: const [
          SliverToBoxAdapter(child: SizedBox(height: 8)),
          SliverToBoxAdapter(child: BannersCarousel()),
          SliverToBoxAdapter(child: SizedBox(height: 8)),
          SliverToBoxAdapter(child: HomeMenuWidget()),
          SliverToBoxAdapter(child: SizedBox(height: 12)),
        ],
      ),
    );
  }
}
