import 'package:flutter/material.dart';

import '../../tokens/glyph_typography.dart';

/// A key-value row in the order totals section.
///
/// Matches `.summary-line` from the design:
/// - Both sides: 15px, textSecondary
/// - Used for subtotal, fees, and other secondary totals
///
/// ```dart
/// GlyphSummaryLine(label: 'Subtotal', value: r'$499.00'),
/// GlyphSummaryLine(label: 'Service Fee (5%)', value: r'$24.95'),
/// ```
class GlyphSummaryLine extends StatelessWidget {
  const GlyphSummaryLine({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GlyphTextStyles.body),
        Text(value, style: GlyphTextStyles.body),
      ],
    );
  }
}
