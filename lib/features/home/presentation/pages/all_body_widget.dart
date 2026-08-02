import 'package:flutter/material.dart';
import 'package:mobile/features/banners/presentation/widgets/banners_carousel.dart';
import 'package:mobile/features/home/presentation/widgets/home_menu_widget.dart';

class AllBodyWidget extends StatefulWidget {
  const AllBodyWidget({super.key});

  @override
  State<AllBodyWidget> createState() => _AllBodyWidgetState();
}

class _AllBodyWidgetState extends State<AllBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          const SliverToBoxAdapter(child: BannersCarousel()),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          const SliverToBoxAdapter(child: HomeMenuWidget()),
        ],
      ),
    );
  }
}
