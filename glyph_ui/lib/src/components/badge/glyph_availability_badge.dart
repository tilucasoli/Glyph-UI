import 'package:flutter/material.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_radius.dart';
import '../../tokens/glyph_typography.dart';

/// Small pill badge indicating ticket availability.
///
/// Matches `.ticket-availability` from the design reference:
/// - Background: --border-light (#f0f0f0)
/// - Border radius: --radius-pill
/// - Padding: 4px vertical, 10px horizontal
/// - Font: 11px, w600, textSecondary
///
/// ```dart
/// GlyphAvailabilityBadge(label: 'Available')
/// GlyphAvailabilityBadge(label: 'Only 12 left')
/// ```
class GlyphAvailabilityBadge extends StatelessWidget {
  const GlyphAvailabilityBadge({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      decoration: const BoxDecoration(
        color: GlyphColors.borderLight,
        borderRadius: GlyphRadius.borderPill,
      ),
      child: Text(label, style: GlyphTextStyles.badge),
    );
  }
}
