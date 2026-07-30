import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/bloc/main_bloc.dart';
import 'package:mobile/core/theme/app_colors.dart';
import 'package:mobile/features/category/extensions/category_localization_extension.dart';
import 'package:mobile/features/category/models/category_model.dart';

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

class CategoryDetailScreen extends StatelessWidget {
  const CategoryDetailScreen({super.key, required this.model});

  final CategoryModel model;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final language = _languageFromCode(
      context.select((MainBloc bloc) => bloc.state.locale.languageCode),
    );
    final mediaUrl = model.media?.fullUrl;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 220,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(model.localizedName(language)),
              background: mediaUrl != null
                  ? Image.network(
                      mediaUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: colors.surfaceVariant,
                        child: Icon(
                          Icons.image_outlined,
                          color: colors.textDisabled,
                          size: 48,
                        ),
                      ),
                    )
                  : Container(
                      color: colors.surfaceVariant,
                      child: Icon(
                        Icons.image_outlined,
                        color: colors.textDisabled,
                        size: 48,
                      ),
                    ),
            ),
          ),
          // TODO: подгрузить и показать товары этой категории, когда появится ProductBloc/API.
          SliverFillRemaining(
            hasScrollBody: false,
            child: _ProductsPlaceholder(colors: colors),
          ),
        ],
      ),
    );
  }
}

class _ProductsPlaceholder extends StatelessWidget {
  const _ProductsPlaceholder({required this.colors});

  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.primaryLight.withValues(alpha: 0.12),
              ),
              child: Icon(
                Icons.inventory_2_outlined,
                size: 38,
                color: colors.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Товары скоро появятся',
              textAlign: TextAlign.center,
              style: textTheme.titleMedium,
            ),
            const SizedBox(height: 6),
            Text(
              'Мы работаем над тем, чтобы показать здесь товары этой категории',
              textAlign: TextAlign.center,
              style: textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
