import 'package:flutter/material.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_typography.dart';

/// Dot + label status indicator.
///
/// Matches `.checkin-status` from the design reference:
/// - 8 × 8px filled circle with [color]
/// - 6px gap
/// - Label in 13px w500
///
/// ```dart
/// // Checked in
/// GlyphStatusIndicator(
///   label: 'Checked In',
///   color: GlyphColors.statusSuccess,
/// )
///
/// // Pending
/// GlyphStatusIndicator(
///   label: 'Pending',
///   color: GlyphColors.borderMedium,
/// )
///
/// // Named constructors
/// GlyphStatusIndicator.checkedIn()
/// GlyphStatusIndicator.pending()
/// ```
class GlyphStatusIndicator extends StatelessWidget {
  const GlyphStatusIndicator({
    super.key,
    required this.label,
    required this.color,
  });

  factory GlyphStatusIndicator.checkedIn({String label = 'Checked In'}) =>
      GlyphStatusIndicator(label: label, color: GlyphColors.statusSuccess);

  factory GlyphStatusIndicator.pending({String label = 'Pending'}) =>
      GlyphStatusIndicator(label: label, color: GlyphColors.borderMedium);

  factory GlyphStatusIndicator.warning({required String label}) =>
      GlyphStatusIndicator(label: label, color: GlyphColors.statusWarning);

  factory GlyphStatusIndicator.danger({required String label}) =>
      GlyphStatusIndicator(label: label, color: GlyphColors.accentDanger);

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: GlyphTextStyles.small.copyWith(
            fontWeight: FontWeight.w500,
            color: GlyphColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
