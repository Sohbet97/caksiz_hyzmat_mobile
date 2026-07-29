import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/bloc/main_bloc.dart';
import 'package:mobile/features/category/bloc/category_bloc.dart';
import 'package:mobile/features/category/models/category_model.dart';
import 'package:mobile/features/category/presentation/widgets/category_breadcrumb.dart';
import 'package:mobile/features/category/presentation/widgets/category_empty_view.dart';
import 'package:mobile/features/category/presentation/widgets/category_sidebar.dart';
import 'package:mobile/features/category/presentation/widgets/category_subcategory_grid.dart';

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

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int _selectedRootIndex = 0;
  final List<CategoryModel> _drillPath = [];

  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(LoadCategoriesEvent());
  }

  void _onSelectRoot(int index) {
    setState(() {
      _selectedRootIndex = index;
      _drillPath.clear();
    });
  }

  void _onTapSubcategory(CategoryModel category) {
    if (category.children.isEmpty) return;
    setState(() => _drillPath.add(category));
  }

  void _onTapBreadcrumb(int index) {
    setState(() {
      if (index == 0) {
        _drillPath.clear();
      } else {
        _drillPath.removeRange(index - 1, _drillPath.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final language = _languageFromCode(
      context.select((MainBloc bloc) => bloc.state.locale.languageCode),
    );

    return SafeArea(
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryError) {
            return _ErrorView(
              message: state.message,
              onRetry: () =>
                  context.read<CategoryBloc>().add(LoadCategoriesEvent()),
            );
          }

          if (state is! CategoryLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          final roots = state.treeList;
          if (roots.isEmpty) {
            return CategoryEmptyView(
              onRefresh: () =>
                  context.read<CategoryBloc>().add(LoadCategoriesEvent()),
            );
          }

          final rootIndex = _selectedRootIndex < roots.length
              ? _selectedRootIndex
              : 0;
          final selectedRoot = roots[rootIndex];
          final breadcrumbPath = [selectedRoot, ..._drillPath];
          final currentChildren = _drillPath.isEmpty
              ? selectedRoot.children
              : _drillPath.last.children;

          return Column(
            children: [
              CategoryBreadcrumb(
                path: breadcrumbPath,
                language: language,
                onTap: _onTapBreadcrumb,
              ),
              const Divider(height: 1),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CategorySidebar(
                      categories: roots,
                      language: language,
                      selectedIndex: rootIndex,
                      onSelect: _onSelectRoot,
                    ),
                    const VerticalDivider(width: 1),
                    Expanded(
                      child: CategorySubcategoryGrid(
                        categories: currentChildren,
                        language: language,
                        onTap: _onTapSubcategory,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 12),
          ElevatedButton(onPressed: onRetry, child: const Text('Повторить')),
        ],
      ),
    );
  }
}
