import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';

class HomeMenuWidget extends StatelessWidget {
  const HomeMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = S.of(context);
    return Container(
      height: 70,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: [
          _BuildItem(
            title: localization.schools,
            image: 'assets/images/okuwlar.gif',
            badgeCount: 0,
            onTap: () {
              // TODO click to schools screen
            },
          ),

          _BuildItem(
            title: localization.cargo,
            image: 'assets/images/cargo.gif',
            badgeCount: 0,
            onTap: () {
              // TODO click to cargo
            },
          ),

          _BuildItem(
            title: localization.brands,
            image: 'assets/images/brand.png',
            badgeCount: 0,
            onTap: () {
              // TODO click to brands
            },
          ),

          _BuildItem(
            title: localization.top_products,
            image: 'assets/images/top.gif',
            badgeCount: 0,
            onTap: () {
              // TODO click to top products
            },
          ),

          _BuildItem(
            title: localization.aksiyalar,
            image: 'assets/images/aksiya.gif',
            badgeCount: 0,
            onTap: () {
              // TODO click to aksiyalar
            },
          ),

          _BuildItem(
            title: localization.new_added,
            image: 'assets/images/new.gif',
            badgeCount: 0,
            onTap: () {
              // TODO click to new
            },
          ),

          _BuildItem(
            title: localization.maslahat_berilyanler,
            image: 'assets/images/rekomen.gif',
            badgeCount: 0,
            onTap: () {
              // TODO click to reçomended
            },
          ),

          _BuildItem(
            title: localization.favorites,
            image: 'assets/images/favorite.gif',
            badgeCount: 0,
            onTap: () {
              // TODO click to favorites
            },
          ),
        ],
      ),
    );
  }
}

class _BuildItem extends StatelessWidget {
  final String title;
  final String image;
  final int badgeCount;
  final VoidCallback onTap;
  const _BuildItem({
    required this.title,
    required this.image,
    required this.badgeCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 78,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(image, height: 40, width: 40, fit: BoxFit.fill),
                const SizedBox(height: 4),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            if (badgeCount > 0)
              Positioned(
                top: 0,
                right: 15, // Podpravte otstup pod vashu ikonku
                child: Badge(
                  backgroundColor: Colors.red,
                  label: Text(
                    badgeCount.toString(),
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
