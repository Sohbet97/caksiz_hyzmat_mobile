import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';

class ProductDetailGalleryWidget extends StatefulWidget {
  const ProductDetailGalleryWidget({
    super.key,
    required this.images,
    required this.onSharePressed,
  });

  final List<String> images;
  final VoidCallback onSharePressed;

  @override
  State<ProductDetailGalleryWidget> createState() =>
      _ProductDetailGalleryWidgetState();
}

class _ProductDetailGalleryWidgetState
    extends State<ProductDetailGalleryWidget> {
  final _controller = PageController();
  int _index = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: widget.images.isEmpty
              ? Container(color: colors.surfaceVariant)
              : PageView.builder(
                  controller: _controller,
                  itemCount: widget.images.length,
                  onPageChanged: (i) => setState(() => _index = i),
                  itemBuilder: (context, i) => CachedNetworkImage(
                    imageUrl: widget.images[i],
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Container(color: colors.surfaceVariant),
                    errorWidget: (context, url, error) =>
                        Container(color: colors.surfaceVariant),
                  ),
                ),
        ),
        Positioned(
          top: 12,
          left: 12,
          child: _CircleIconButton(
            icon: Icons.arrow_back,
            onTap: () => context.pop(),
          ),
        ),
        Positioned(
          top: 12,
          right: 12,
          child: Row(
            children: [
              _CircleIconButton(
                icon: Icons.share_outlined,
                onTap: widget.onSharePressed,
              ),
            ],
          ),
        ),
        if (widget.images.length > 1)
          Positioned(
            bottom: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.45),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${_index + 1}/${widget.images.length}',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
      ],
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.35),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}