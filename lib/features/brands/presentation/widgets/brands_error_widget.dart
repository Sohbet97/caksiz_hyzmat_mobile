import 'package:flutter/material.dart';
import 'package:mobile/generated/l10n.dart';

class BrandsErrorWidget extends StatelessWidget {
  const BrandsErrorWidget({
    super.key,
    required this.title,
    required this.onTap,
  });
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48),
            const SizedBox(height: 12),
            Text(title, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: onTap, child: Text(S.of(context).retry)),
          ],
        ),
      ),
    );
  }
}
