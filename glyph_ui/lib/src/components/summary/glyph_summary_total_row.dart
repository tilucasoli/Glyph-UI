import 'package:flutter/material.dart';

import '../../tokens/glyph_typography.dart';

/// The prominent total row at the bottom of the order summary.
///
/// Matches `.summary-total-row` from the design:
/// - Both sides: 20px, w700, textPrimary
///
/// ```dart
/// GlyphSummaryTotalRow(label: 'Total', total: r'$523.95'),
/// ```
class GlyphSummaryTotalRow extends StatelessWidget {
  const GlyphSummaryTotalRow({
    super.key,
    required this.label,
    required this.total,
  });

  final String label;
  final String total;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: GlyphTextStyles.summaryTotal),
        Text(total, style: GlyphTextStyles.summaryTotal),
      ],
    );
  }
}
