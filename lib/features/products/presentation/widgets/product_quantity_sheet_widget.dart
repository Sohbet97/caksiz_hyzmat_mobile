import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../generated/l10n.dart';

class ProductQuantitySheetWidget extends StatefulWidget {
  const ProductQuantitySheetWidget({
    super.key,
    required this.price,
    required this.currencyCode,
  });

  final double price;
  final String currencyCode;

  @override
  State<ProductQuantitySheetWidget> createState() =>
      _ProductQuantitySheetWidgetState();
}

class _ProductQuantitySheetWidgetState
    extends State<ProductQuantitySheetWidget> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;
    final localization = S.of(context);
    final total = widget.price * _quantity;

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '${total.toStringAsFixed(2)} ${widget.currencyCode}',
            style: textTheme.headlineSmall?.copyWith(
              color: colors.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _StepButton(
                icon: Icons.remove,
                onTap: _quantity > 1
                    ? () => setState(() => _quantity--)
                    : null,
              ),
              SizedBox(
                width: 60,
                child: Text(
                  '$_quantity',
                  textAlign: TextAlign.center,
                  style: textTheme.titleLarge,
                ),
              ),
              _StepButton(
                icon: Icons.add,
                onTap: () => setState(() => _quantity++),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(localization.productAddToCart)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                foregroundColor: colors.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text(localization.productAddToCart),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final disabled = onTap == null;

    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: disabled ? colors.textDisabled : colors.primary,
          ),
        ),
        child: Icon(
          icon,
          size: 18,
          color: disabled ? colors.textDisabled : colors.primary,
        ),
      ),
    );
  }
}