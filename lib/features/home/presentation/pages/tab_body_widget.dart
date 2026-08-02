import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/bloc/main_bloc.dart';
import 'package:mobile/features/category/models/category_model.dart';
import 'package:mobile/features/category/presentation/widgets/category_sidebar_item.dart';
import 'package:mobile/features/products/models/product_filter_model.dart';
import 'package:mobile/features/products/presentation/widgets/products_grid_section.dart';

// language: 0 = tm, 1 = ru, 2 = en
int _languageFromCode(String code) {
  switch (code) {
    case 'ru':
      return 1;
    case 'en':
      return 2;
    default:
      return 0;
  }
}

class TabBodyWidget extends StatefulWidget {
  const TabBodyWidget({super.key, required this.model});
  final CategoryModel model;

  @override
  State<TabBodyWidget> createState() => _TabBodyWidgetState();
}

class _TabBodyWidgetState extends State<TabBodyWidget>
    with AutomaticKeepAliveClientMixin {
  int? _selectedChildId;

  @override
  bool get wantKeepAlive => true;

  void _onChildTap(CategoryModel category) {
    setState(() {
      _selectedChildId = _selectedChildId == category.id ? null : category.id;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final language = _languageFromCode(
      context.select((MainBloc bloc) => bloc.state.locale.languageCode),
    );
    final children = widget.model.children;

    return ProductsGridSection(
      filter: ProductFilterModel(
        categoryId: _selectedChildId ?? widget.model.id,
      ),
      leadingSlivers: [
        if (children.isNotEmpty) ...[
          SliverToBoxAdapter(
            child: SizedBox(
              height: 130,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                itemCount: children.length,
                itemBuilder: (context, index) {
                  final category = children[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: SizedBox(
                      width: 84,
                      child: CategorySidebarItem(
                        category: category,
                        language: language,
                        isSelected: _selectedChildId == category.id,
                        onTap: () => _onChildTap(category),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
        ],
      ],
    );
  }
}
