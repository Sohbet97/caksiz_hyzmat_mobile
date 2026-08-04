import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../models/product_detail_model.dart';

class ProductDetailVariantWidget extends StatefulWidget {
  const ProductDetailVariantWidget({super.key, required this.variations});

  final List<ProductVariationModel> variations;

  @override
  State<ProductDetailVariantWidget> createState() =>
      _ProductDetailVariantWidgetState();
}

class _ProductDetailVariantWidgetState
    extends State<ProductDetailVariantWidget> {
  int? _selectedColorId;
  int? _selectedSizeId;

  List<ProductColorModel> get _colors {
    final seen = <int>{};
    return widget.variations
        .map((v) => v.color)
        .whereType<ProductColorModel>()
        .where((c) => seen.add(c.id))
        .toList();
  }

  List<ProductSizeModel> get _sizes {
    final seen = <int>{};
    return widget.variations
        .map((v) => v.size)
        .whereType<ProductSizeModel>()
        .where((s) => seen.add(s.id))
        .toList();
  }

 String _summaryText(S localization) {
    final parts = <String>[];
    ProductColorModel? color;
    for (final c in _colors) {
      if (c.id == _selectedColorId) {
        color = c;
        break;
      }
    }
    ProductSizeModel? size;
    for (final s in _sizes) {
      if (s.id == _selectedSizeId) {
        size = s;
        break;
      }
    }
    if (color != null) parts.add(color.nameRu);
    if (size != null) parts.add(size.value);
    if (parts.isEmpty) return localization.productSelectOption;
    return parts.join(', ');
  }

  void _openSelector() {
    final localization = S.of(context);
    final colors = Theme.of(context).extension<AppColors>()!;

    showModalBottomSheet(
      context: context,
      backgroundColor: colors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (sheetContext, setSheetState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_colors.isNotEmpty) ...[
                    Text(
                      localization.productColor,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: _colors.map((c) {
                        final isSelected = c.id == _selectedColorId;
                        return GestureDetector(
                          onTap: () {
                            setSheetState(() => _selectedColorId = c.id);
                            setState(() => _selectedColorId = c.id);
                          },
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: c.swatch,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? colors.primary
                                    : colors.border,
                                width: isSelected ? 2.5 : 1,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                  ],
                  if (_sizes.isNotEmpty) ...[
                    Text(
                      localization.productSize,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: _sizes.map((s) {
                        final isSelected = s.id == _selectedSizeId;
                        return GestureDetector(
                          onTap: () {
                            setSheetState(() => _selectedSizeId = s.id);
                            setState(() => _selectedSizeId = s.id);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isSelected
                                    ? colors.primary
                                    : colors.border,
                                width: isSelected ? 1.5 : 1,
                              ),
                              color: isSelected
                                  ? colors.primaryLight.withOpacity(0.12)
                                  : null,
                            ),
                            child: Text(
                              s.value,
                              style: TextStyle(
                                color: isSelected
                                    ? colors.primary
                                    : colors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.variations.isEmpty) return const SizedBox.shrink();

    final colors = Theme.of(context).extension<AppColors>()!;
    final localization = S.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: _openSelector,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(color: colors.border),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Text(
                localization.productOnlyOneOption,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const Spacer(),
              Text(
                _summaryText(localization),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colors.textSecondary,
                    ),
              ),
              const SizedBox(width: 4),
              Icon(Icons.chevron_right, color: colors.textSecondary, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}