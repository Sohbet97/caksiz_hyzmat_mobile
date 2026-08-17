import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'school_detail_gallery_widget.dart';

class SchoolFullScreenGallery extends StatefulWidget {
  const SchoolFullScreenGallery({
    super.key,
    required this.media,
    this.initialIndex = 0,
  });

  final List<SchoolMediaItem> media;
  final int initialIndex;

  @override
  State<SchoolFullScreenGallery> createState() =>
      _SchoolFullScreenGalleryState();
}

class _SchoolFullScreenGalleryState extends State<SchoolFullScreenGallery> {
  late int _index = widget.initialIndex;
  late final _controller = PageController(initialPage: widget.initialIndex);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close, color: Colors.white),
        ),
        title: Text(
          '${_index + 1} / ${widget.media.length}',
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        centerTitle: true,
      ),
      body: PageView.builder(
        controller: _controller,
        itemCount: widget.media.length,
        onPageChanged: (i) => setState(() => _index = i),
        itemBuilder: (context, i) {
          final item = widget.media[i];
          if (item.isVideo) {
            return SchoolVideoPlayerWidget(url: item.url);
          }
          return InteractiveViewer(
            minScale: 1,
            maxScale: 4,
            child: Center(
              child: CachedNetworkImage(
                imageUrl: item.url,
                fit: BoxFit.contain,
                errorWidget: (context, url, error) => const Icon(
                  Icons.image_not_supported_outlined,
                  color: Colors.white38,
                  size: 40,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}