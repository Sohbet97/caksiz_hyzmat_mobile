import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/models/media_model.dart';
import '../../data/models/school_detail_model.dart';
import 'school_full_screen_gallery.dart';

class SchoolMediaItem {
  const SchoolMediaItem({
    required this.url,
    this.thumbnailUrl,
    this.isVideo = false,
  });

  final String url;
  final String? thumbnailUrl;
  final bool isVideo;
}

List<SchoolMediaItem> buildSchoolMediaList(SchoolDetailModel detail) {
  final items = <SchoolMediaItem>[];

  void addMedia(MediaDetailModel? media) {
    if (media == null) return;
    final url = media.fullUrl;
    if (url.isEmpty) return;
    items.add(
      SchoolMediaItem(
        url: url,
        thumbnailUrl: media.thumbnailUrl,
        isVideo: media.mediaType == 'video',
      ),
    );
  }

  for (final g in detail.gallery) {
    addMedia(g.media);
  }
  if (items.isEmpty) {
    addMedia(detail.thumbnailMedia);
  }

  return items;
}

class SchoolDetailGalleryWidget extends StatefulWidget {
  const SchoolDetailGalleryWidget({
    super.key,
    required this.media,
    required this.onSharePressed,
    required this.onFavoritePressed,
  });

  final List<SchoolMediaItem> media;
  final VoidCallback onSharePressed;
  final VoidCallback onFavoritePressed;

  @override
  State<SchoolDetailGalleryWidget> createState() =>
      _SchoolDetailGalleryWidgetState();
}

class _SchoolDetailGalleryWidgetState
    extends State<SchoolDetailGalleryWidget> {
  final _controller = PageController();
  int _index = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openFullScreen(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            SchoolFullScreenGallery(media: widget.media, initialIndex: index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

        return SizedBox(
      height: 240,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
        child: Stack(
          children: [
          widget.media.isEmpty
              ? Container(color: colors.surfaceVariant)
              : PageView.builder(
                  controller: _controller,
                  itemCount: widget.media.length,
                  onPageChanged: (i) => setState(() => _index = i),
                  itemBuilder: (context, i) => GestureDetector(
                    onTap: () => _openFullScreen(i),
                    child: _SchoolMediaThumb(item: widget.media[i]),
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
                  icon: Icons.favorite_border,
                  onTap: widget.onFavoritePressed,
                ),
                const SizedBox(width: 8),
                _CircleIconButton(
                  icon: Icons.share_outlined,
                  onTap: widget.onSharePressed,
                ),
              ],
            ),
          ),
          if (widget.media.length > 1)
            Positioned(
              bottom: 12,
              right: 12,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.45),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${_index + 1}/${widget.media.length}',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
        ],
      ),
    ),
    );
  }
}

class _SchoolMediaThumb extends StatelessWidget {
  const _SchoolMediaThumb({required this.item});

  final SchoolMediaItem item;

  @override
  Widget build(BuildContext context) {
    final displayUrl =
        item.isVideo ? (item.thumbnailUrl ?? '') : item.url;

    if (displayUrl.isEmpty) {
      return Container(
        color: Colors.grey.shade300,
        child: const Icon(Icons.image_not_supported_outlined, size: 32),
      );
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        CachedNetworkImage(
          imageUrl: displayUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) =>
              Container(color: Colors.grey.shade200),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey.shade200,
            child: const Icon(Icons.image_not_supported_outlined, size: 32),
          ),
        ),
        if (item.isVideo)
          Center(
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
              child:
                  const Icon(Icons.play_arrow, color: Colors.white, size: 34),
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
        width: 38,
        height: 38,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.black87, size: 19),
      ),
    );
  }
}

class SchoolVideoPlayerWidget extends StatefulWidget {
  const SchoolVideoPlayerWidget({super.key, required this.url});

  final String url;

  @override
  State<SchoolVideoPlayerWidget> createState() =>
      _SchoolVideoPlayerWidgetState();
}

class _SchoolVideoPlayerWidgetState extends State<SchoolVideoPlayerWidget> {
  VideoPlayerController? _controller;
  bool _initialized = false;
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    try {
      final controller =
          VideoPlayerController.networkUrl(Uri.parse(widget.url));
      _controller = controller;
      await controller.initialize();
      if (mounted) setState(() => _initialized = true);
    } catch (_) {
      if (mounted) setState(() => _failed = true);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_failed) {
      return const Center(
        child: Icon(
          Icons.error_outline,
          color: Colors.white54,
          size: 40,
        ),
      );
    }

    if (!_initialized || _controller == null) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _controller!.value.isPlaying
              ? _controller!.pause()
              : _controller!.play();
        });
      },
      child: Center(
        child: AspectRatio(
          aspectRatio: _controller!.value.aspectRatio,
          child: Stack(
            alignment: Alignment.center,
            children: [
              VideoPlayer(_controller!),
              if (!_controller!.value.isPlaying)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(12),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 44,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}