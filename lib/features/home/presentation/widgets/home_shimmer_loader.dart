import 'package:flutter/material.dart';

/// =====================================================
/// TEMU-style Shimmer Loader for Home Page
/// Bez vneshnih paketov — chistый AnimationController.
/// Prosto vstav <HomeShimmerLoader/> poka idet zagruzka dannyh.
/// =====================================================

class HomeShimmerLoader extends StatefulWidget {
  const HomeShimmerLoader({super.key, this.gridItemCount = 8});

  final int gridItemCount;

  @override
  State<HomeShimmerLoader> createState() => _HomeShimmerLoaderState();
}

class _HomeShimmerLoaderState extends State<HomeShimmerLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          // Top banner (карусель)
          _ShimmerBox(
            controller: _controller,
            height: 160,
            margin: const EdgeInsets.fromLTRB(12, 12, 12, 16),
            borderRadius: 14,
          ),

          // Category row (kruglye ikonki + text)
          SizedBox(
            height: 90,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: 6,
              separatorBuilder: (_, __) => const SizedBox(width: 14),
              itemBuilder: (_, __) => Column(
                children: [
                  _ShimmerBox(
                    controller: _controller,
                    width: 56,
                    height: 56,
                    borderRadius: 28,
                  ),
                  const SizedBox(height: 8),
                  _ShimmerBox(
                    controller: _controller,
                    width: 44,
                    height: 10,
                    borderRadius: 4,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Section title (napr. "Flash Sale")
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: _ShimmerBox(
              controller: _controller,
              width: 140,
              height: 18,
              borderRadius: 4,
            ),
          ),

          const SizedBox(height: 12),

          // Product grid (kak na TEMU: 2 kolonki, kartochka s foto+cena)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: widget.gridItemCount,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.62,
            ),
            itemBuilder: (_, __) =>
                _ProductCardShimmer(controller: _controller),
          ),
        ],
      ),
    );
  }
}

/// Odna kartochka tovara-skelet: foto + 2 stroki teksta + cena
class _ProductCardShimmer extends StatelessWidget {
  const _ProductCardShimmer({required this.controller});

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _ShimmerBox(
            controller: controller,
            width: double.infinity,
            borderRadius: 10,
          ),
        ),
        const SizedBox(height: 8),
        _ShimmerBox(
          controller: controller,
          width: double.infinity,
          height: 12,
          borderRadius: 4,
        ),
        const SizedBox(height: 6),
        _ShimmerBox(
          controller: controller,
          width: 80,
          height: 12,
          borderRadius: 4,
        ),
        const SizedBox(height: 6),
        _ShimmerBox(
          controller: controller,
          width: 50,
          height: 14,
          borderRadius: 4,
        ),
      ],
    );
  }
}

/// Sdvigaet gradient po shirine boksa. Ispolzuется vmesto Alignment,
/// chtoby diapazon dvizheniya byl shire chem sam blok — togda v moment
/// "petli" animatsii (value: 1 -> 0) na ekrane viden tolko odnorodnyy
/// base-cvet, i pereход nezameten (net migания/dзержка).
class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({required this.slidePercent});

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}

/// Bazovyy shimmer-blok s dvizhushimsya gradientom (bez migания na petle)
class _ShimmerBox extends StatelessWidget {
  const _ShimmerBox({
    required this.controller,
    this.width,
    this.height,
    this.borderRadius = 8,
    this.margin,
  });

  final AnimationController controller;
  final double? width;
  final double? height;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final baseColor = Colors.grey.shade300;
    final highlightColor = Colors.grey.shade100;

    return Container(
      width: width,
      height: height,
      margin: margin,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          // value idet 0 -> 1, slidePercent idet -1.5 -> 1.5.
          // Na kraynih tochkah (blizko k -1.5 i 1.5) highlight-polosa
          // uzhe za predelami vidimoy oblasti — poetomu petля neзametna.
          final slidePercent = controller.value * 3 - 1.5;

          return ShaderMask(
            blendMode: BlendMode.srcATop,
            shaderCallback: (bounds) {
              return LinearGradient(
                colors: [
                  baseColor,
                  baseColor,
                  highlightColor,
                  baseColor,
                  baseColor,
                ],
                stops: const [0.0, 0.35, 0.5, 0.65, 1.0],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                transform: _SlidingGradientTransform(
                  slidePercent: slidePercent,
                ),
              ).createShader(bounds);
            },
            child: Container(
              decoration: BoxDecoration(
                color: baseColor,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// =====================================================
/// Primer ispolzovaniya na Home Page:
///
/// bool isLoading = true;
///
/// Scaffold(
///   body: isLoading
///       ? const HomeShimmerLoader(gridItemCount: 8)
///       : YourActualHomeContent(),
/// );
/// =====================================================
