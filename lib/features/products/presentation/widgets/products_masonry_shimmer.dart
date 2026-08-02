import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductsMasonryShimmer extends StatelessWidget {
  const ProductsMasonryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    const heights = [220.0, 180.0, 190.0, 230.0, 200.0, 210.0];

    return SliverMasonryGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childCount: heights.length,
      itemBuilder: (context, index) => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          height: heights[index],
          child: Container(color: colors.surfaceContainerHighest),
        ),
      ),
    );
  }
}
