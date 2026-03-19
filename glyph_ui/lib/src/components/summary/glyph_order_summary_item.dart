import 'package:flutter/material.dart';

import '../../tokens/glyph_colors.dart';

/// A single line item in the order summary.
///
/// Matches `.summary-item` from the design:
/// - Left: item name (15px, w500, textPrimary) + quantity label (13px, textSecondary)
/// - Right: price (15px, w600, textPrimary)
///
/// ```dart
/// GlyphOrderSummaryItem(
///   name: 'General Admission',
///   quantity: 1,
///   price: r'$499.00',
/// )
/// ```
class GlyphOrderSummaryItem extends StatelessWidget {
  const GlyphOrderSummaryItem({
    super.key,
    required this.name,
    required this.quantity,
    required this.price,
  });

  final String name;
  final int quantity;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: GlyphColors.textPrimary,
              ),
            ),
            Text(
              'Qty: $quantity',
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                color: GlyphColors.textSecondary,
              ),
            ),
          ],
        ),
        Text(
          price,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: GlyphColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
