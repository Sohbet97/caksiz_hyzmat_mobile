import 'package:flutter/material.dart';
import 'package:mobile/core/theme/app_colors.dart';
import 'package:mobile/features/category/models/category_model.dart';
import 'package:mobile/features/category/presentation/widgets/category_sidebar_item.dart';

class CategorySidebar extends StatelessWidget {
  const CategorySidebar({
    super.key,
    required this.categories,
    required this.language,
    required this.selectedIndex,
    required this.onSelect,
  });

  final List<CategoryModel> categories;
  final int language;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return Container(
      width: 96,
      color: colors.surface,
      child: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) => CategorySidebarItem(
          category: categories[index],
          language: language,
          isSelected: index == selectedIndex,
          onTap: () => onSelect(index),
        ),
      ),
    );
  }
}
