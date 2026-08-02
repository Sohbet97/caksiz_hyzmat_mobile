import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/brands/bloc/brand_bloc.dart';
import 'package:mobile/features/brands/model/brand_filter_model.dart';
import 'package:mobile/features/brands/model/brand_model.dart';
import 'package:mobile/features/brands/presentation/widgets/brand_loading_shimmer.dart';
import 'package:mobile/features/brands/presentation/widgets/brands_error_widget.dart';

import '../../../generated/l10n.dart';

class BrandsScreen extends StatefulWidget {
  const BrandsScreen({super.key});

  @override
  State<BrandsScreen> createState() => _BrandsScreenState();
}

class _BrandsScreenState extends State<BrandsScreen> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    final brandBloc = context.read<BrandBloc>();
    if (brandBloc.state is! BrandLoaded) {
      brandBloc.add(LoadBrands(BrandFilterModel(limit: 30, page: 1)));
    }
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      context.read<BrandBloc>().add(const LoadMoreBrands());
    }
  }

  Future<void> _onRefresh() {
    final bloc = context.read<BrandBloc>();
    bloc.add(const RefreshBrands());
    return bloc.stream.firstWhere(
      (state) => state is BrandLoaded || state is BrandError,
    );
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      final search = value.trim();
      context.read<BrandBloc>().add(
        LoadBrands(
          BrandFilterModel(
            limit: 30,
            page: 1,
            search: search.isEmpty ? null : search,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = S.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(localization.brands)),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                textInputAction: TextInputAction.search,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<BrandBloc, BrandState>(
                builder: (context, state) {
                  if (state is BrandInitial || state is BrandLoading) {
                    return const BrandLoadingShimmerWidget();
                  }

                  if (state is BrandError) {
                    return BrandsErrorWidget(
                      title: state.message,
                      onTap: () {
                        context.read<BrandBloc>().add(
                          LoadBrands(state.filter ?? BrandFilterModel()),
                        );
                      },
                    );
                  }

                  final loaded = state as BrandLoaded;
                  if (loaded.brands.isEmpty) {
                    return Center(child: Text(localization.categoriesEmpty));
                  }

                  return RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        SliverPadding(
                          padding: const EdgeInsets.all(16),
                          sliver: SliverGrid(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 130,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12,
                                  childAspectRatio: 0.78,
                                ),
                            delegate: SliverChildBuilderDelegate(
                              (context, index) =>
                                  _BrandCard(brand: loaded.brands[index]),
                              childCount: loaded.brands.length,
                            ),
                          ),
                        ),
                        if (loaded.hasMore)
                          const SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 24),
                              child: Center(child: CircularProgressIndicator()),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BrandCard extends StatelessWidget {
  const _BrandCard({required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final thumbnailUrl = brand.media?.fullUrl;

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: colors.primaryContainer.withValues(alpha: 0.35),
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: thumbnailUrl != null
                        ? CachedNetworkImage(
                            imageUrl: thumbnailUrl,
                            width: 52,
                            height: 52,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                                _BrandPlaceholder(theme: theme),
                          )
                        : _BrandPlaceholder(theme: theme),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  brand.name,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (brand.description.isNotEmpty) ...[
                  const SizedBox(height: 3),
                  Text(
                    brand.description,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.onSurfaceVariant,
                      fontSize: 11,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BrandPlaceholder extends StatelessWidget {
  const _BrandPlaceholder({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.storefront_rounded,
      color: theme.colorScheme.primary,
      size: 28,
    );
  }
}
