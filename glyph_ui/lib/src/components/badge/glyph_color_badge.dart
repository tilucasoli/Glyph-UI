import 'package:flutter/material.dart';

import '../../tokens/glyph_colors.dart';

/// Pill-shaped badge with a fully custom color scheme.
///
/// Matches `.tier-badge` variants from the design reference.
/// Use the named constructors for the standard tier presets, or
/// supply raw colors for custom use-cases.
///
/// ```dart
/// // Standard presets
/// GlyphColorBadge.vip()
/// GlyphColorBadge.general()
/// GlyphColorBadge.student()
/// GlyphColorBadge.workshop()
///
/// // Custom
/// GlyphColorBadge(
///   label: 'Sponsor',
///   color: Color(0xFF0369A1),
///   backgroundColor: Color(0xFFE0F2FE),
///   borderColor: Color(0xFFBAE6FD),
/// )
/// ```
class GlyphColorBadge extends StatelessWidget {
  const GlyphColorBadge({
    super.key,
    required this.label,
    required this.color,
    required this.backgroundColor,
    required this.borderColor,
  });

  /// VIP Pass — purple
  factory GlyphColorBadge.vip({String label = 'VIP Pass'}) => GlyphColorBadge(
        label: label,
        color: const Color(0xFFA21CAF),
        backgroundColor: const Color(0xFFFDF4FF),
        borderColor: const Color(0xFFF5D0FE),
      );

  /// General Admission — blue
  factory GlyphColorBadge.general({String label = 'General Admission'}) =>
      GlyphColorBadge(
        label: label,
        color: const Color(0xFF1D4ED8),
        backgroundColor: const Color(0xFFEFF6FF),
        borderColor: const Color(0xFFDBEAFE),
      );

  /// Student Pass — green
  factory GlyphColorBadge.student({String label = 'Student Pass'}) =>
      GlyphColorBadge(
        label: label,
        color: const Color(0xFF15803D),
        backgroundColor: const Color(0xFFF0FDF4),
        borderColor: const Color(0xFFDCFCE7),
      );

  /// Workshop Bundle — orange
  factory GlyphColorBadge.workshop({String label = 'Workshop Bundle'}) =>
      GlyphColorBadge(
        label: label,
        color: const Color(0xFFC2410C),
        backgroundColor: const Color(0xFFFFF7ED),
        borderColor: const Color(0xFFFFEDD5),
      );

  /// Success / confirmed — emerald
  factory GlyphColorBadge.success({required String label}) => GlyphColorBadge(
        label: label,
        color: GlyphColors.statusSuccess,
        backgroundColor: GlyphColors.statusSuccessSurface,
        borderColor: const Color(0xFF6EE7B7),
      );

  /// Warning / pending — amber
  factory GlyphColorBadge.warning({required String label}) => GlyphColorBadge(
        label: label,
        color: GlyphColors.statusWarning,
        backgroundColor: GlyphColors.statusWarningSurface,
        borderColor: const Color(0xFFFCD34D),
      );

  final String label;
  final Color color;
  final Color backgroundColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
