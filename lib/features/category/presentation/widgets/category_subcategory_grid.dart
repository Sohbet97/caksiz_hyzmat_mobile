import 'package:flutter/material.dart';
import 'package:mobile/features/category/models/category_model.dart';
import 'package:mobile/features/category/presentation/widgets/category_empty_view.dart';
import 'package:mobile/features/category/presentation/widgets/category_grid_item.dart';

class CategorySubcategoryGrid extends StatelessWidget {
  const CategorySubcategoryGrid({
    super.key,
    required this.categories,
    required this.language,
    required this.onTap,
  });

  final List<CategoryModel> categories;
  final int language;
  final ValueChanged<CategoryModel> onTap;

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return const CategoryEmptyView();
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomScrollView(
        slivers: [
          SliverGrid.builder(
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.78,
            ),
            itemBuilder: (context, index) => CategoryGridItem(
              category: categories[index],
              language: language,
              onTap: () => onTap(categories[index]),
            ),
          ),
        ],
      ),
    );
  }
}
