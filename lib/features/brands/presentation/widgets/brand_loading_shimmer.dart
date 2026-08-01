import 'package:flutter/material.dart';

class BrandLoadingShimmerWidget extends StatefulWidget {
  const BrandLoadingShimmerWidget({super.key, this.itemCount = 8});

  final int itemCount;

  @override
  State<BrandLoadingShimmerWidget> createState() =>
      _BrandLoadingShimmerWidgetState();
}

class _BrandLoadingShimmerWidgetState extends State<BrandLoadingShimmerWidget>
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
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 130,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.78,
      ),
      itemCount: widget.itemCount,
      itemBuilder: (_, _) => _BrandCardShimmer(controller: _controller),
    );
  }
}

class _BrandCardShimmer extends StatelessWidget {
  const _BrandCardShimmer({required this.controller});

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _ShimmerBox(
              controller: controller,
              width: 52,
              height: 52,
              borderRadius: 26,
            ),
            const SizedBox(height: 10),
            _ShimmerBox(
              controller: controller,
              width: 64,
              height: 10,
              borderRadius: 4,
            ),
            const SizedBox(height: 6),
            _ShimmerBox(
              controller: controller,
              width: 44,
              height: 8,
              borderRadius: 4,
            ),
          ],
        ),
      ),
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({required this.slidePercent});

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}

class _ShimmerBox extends StatelessWidget {
  const _ShimmerBox({
    required this.controller,
    this.width,
    this.height,
    this.borderRadius = 8,
  });

  final AnimationController controller;
  final double? width;
  final double? height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final baseColor = Colors.grey.shade300;
    final highlightColor = Colors.grey.shade100;

    return SizedBox(
      width: width,
      height: height,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
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
