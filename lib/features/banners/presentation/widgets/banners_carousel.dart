import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/bloc/main_bloc.dart';
import 'package:mobile/core/router/app_router.dart';
import 'package:mobile/features/banners/bloc/banner_bloc.dart';
import 'package:mobile/features/banners/model/banner_filter_model.dart';
import 'package:mobile/features/banners/model/banner_model.dart';

import '../../../../generated/l10n.dart';

class BannersCarousel extends StatefulWidget {
  const BannersCarousel({super.key});

  @override
  State<BannersCarousel> createState() => _BannersCarouselState();
}

class _BannersCarouselState extends State<BannersCarousel> {
  final _pageController = PageController();
  Timer? _autoPlayTimer;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    final bannerBloc = context.read<BannerBloc>();
    if (bannerBloc.state is BannerInitial) {
      bannerBloc.add(LoadBanners(BannerFilterModel()));
    }
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoPlay(int itemCount) {
    _autoPlayTimer?.cancel();
    if (itemCount <= 1) return;

    _autoPlayTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_pageController.hasClients) return;
      _page = (_page + 1) % itemCount;
      _pageController.animateToPage(
        _page,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannerBloc, BannerState>(
      builder: (context, state) {
        if (state is BannerInitial || state is BannerLoading) {
          return const _BannersShimmer();
        }

        if (state is BannerError) {
          return _BannersErrorCard(
            message: state.message,
            onRetry: () {
              context.read<BannerBloc>().add(
                LoadBanners(state.filter ?? BannerFilterModel()),
              );
            },
          );
        }

        final banners = (state as BannerLoaded).banners;
        if (banners.isEmpty) return const SizedBox.shrink();

        _startAutoPlay(banners.length);

        return Column(
          children: [
            SizedBox(
              height: 160,
              child: PageView.builder(
                controller: _pageController,
                itemCount: banners.length,
                onPageChanged: (index) => setState(() => _page = index),
                itemBuilder: (context, index) =>
                    _BannerCard(banner: banners[index]),
              ),
            ),
            if (banners.length > 1) ...[
              const SizedBox(height: 8),
              _DotsIndicator(count: banners.length, activeIndex: _page),
            ],
          ],
        );
      },
    );
  }
}

class _BannerCard extends StatelessWidget {
  const _BannerCard({required this.banner});

  final BannerModel banner;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final locale = context.select((MainBloc bloc) => bloc.state.locale);
    final imageUrl = banner.media?.fullUrl;
    final title = banner.localizedTitle(locale);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          color: colors.surfaceContainerHighest,
          child: InkWell(
            onTap: () => context.push(AppRoutes.bannerDetail, extra: banner),
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (imageUrl != null)
                  CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) =>
                        _BannerPlaceholder(colors: colors),
                  )
                else
                  _BannerPlaceholder(colors: colors),
                if (title.isNotEmpty)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(14, 24, 14, 12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0),
                            Colors.black.withValues(alpha: 0.55),
                          ],
                        ),
                      ),
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BannerPlaceholder extends StatelessWidget {
  const _BannerPlaceholder({required this.colors});

  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors.surfaceContainerHighest,
      alignment: Alignment.center,
      child: Icon(
        Icons.image_outlined,
        color: colors.onSurfaceVariant,
        size: 36,
      ),
    );
  }
}

class _DotsIndicator extends StatelessWidget {
  const _DotsIndicator({required this.count, required this.activeIndex});

  final int count;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == activeIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: isActive ? 18 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: isActive ? colors.primary : colors.outlineVariant,
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }
}

class _BannersShimmer extends StatelessWidget {
  const _BannersShimmer();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 160,
          color: colors.surfaceContainerHighest,
        ),
      ),
    );
  }
}

class _BannersErrorCard extends StatelessWidget {
  const _BannersErrorCard({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final localization = S.of(context);
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 160,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: colors.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: colors.error, size: 28),
            const SizedBox(height: 8),
            Text(localization.nasazlyk_yuze_cykdy),
            const SizedBox(height: 8),
            TextButton(
              onPressed: onRetry,
              child: Text(localization.retry),
            ),
          ],
        ),
      ),
    );
  }
}
