import 'package:flutter/material.dart';

import '../../tokens/glyph_colors.dart';

/// Circular avatar that shows initials or a network image.
///
/// Matches `.avatar` from the design reference:
/// - 32 × 32px circle (configurable via [size])
/// - Falls back to initials when no [imageUrl] is provided
/// - Accepts custom [backgroundColor] / [foregroundColor] per row
///
/// ```dart
/// // Initials only
/// GlyphAvatar(initials: 'AW')
///
/// // Colored initials
/// GlyphAvatar(
///   initials: 'JS',
///   backgroundColor: Color(0xFFE0E7FF),
///   foregroundColor: Color(0xFF4338CA),
/// )
///
/// // Network image
/// GlyphAvatar(initials: 'AW', imageUrl: 'https://…')
/// ```
class GlyphAvatar extends StatelessWidget {
  const GlyphAvatar({
    super.key,
    required this.initials,
    this.imageUrl,
    this.backgroundColor,
    this.foregroundColor,
    this.size = 32,
  });

  final String initials;
  final String? imageUrl;

  /// Defaults to [GlyphColors.borderMedium] when null.
  final Color? backgroundColor;

  /// Defaults to [GlyphColors.textSecondary] when null.
  final Color? foregroundColor;

  /// Diameter in logical pixels. Defaults to 32.
  final double size;

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? GlyphColors.borderMedium;
    final fg = foregroundColor ?? GlyphColors.textSecondary;
    final fontSize = size * 0.3125; // 10 / 32

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bg,
        image: imageUrl != null
            ? DecorationImage(
                image: NetworkImage(imageUrl!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: imageUrl == null
          ? Center(
              child: Text(
                initials.toUpperCase(),
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600,
                  color: fg,
                  height: 1,
                ),
              ),
            )
          : null,
    );
  }
}
