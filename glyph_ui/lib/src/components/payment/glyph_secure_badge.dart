import 'package:flutter/material.dart';

import '../../tokens/glyph_colors.dart';

/// Secure SSL encrypted payment badge.
///
/// Matches `.secure-badge` from the design:
/// - Lock icon + "Secure SSL Encrypted Payment" label
/// - 12px text, textSecondary, centered
/// - Typically placed below the pay button
///
/// ```dart
/// Column(
///   children: [
///     GlyphButton(label: 'Pay \$523.95', onPressed: _pay),
///     const SizedBox(height: 16),
///     const GlyphSecureBadge(),
///   ],
/// )
/// ```
class GlyphSecureBadge extends StatelessWidget {
  const GlyphSecureBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.lock_outline, size: 12, color: GlyphColors.textSecondary),
        SizedBox(width: 6),
        Text(
          'Secure SSL Encrypted Payment',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 12,
            color: GlyphColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
