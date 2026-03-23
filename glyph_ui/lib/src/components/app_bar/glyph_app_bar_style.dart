import 'package:flutter/widgets.dart';

import '../../tokens/glyph_colors.dart';

/// Visual properties for [GlyphAppBar].
///
/// The app bar is a non-interactive chrome region; values are plain fields
/// rather than [WidgetStateProperty].
@immutable
final class GlyphAppBarStyle {
  const GlyphAppBarStyle({
    required this.backgroundColor,
    required this.bottomBorder,
  });

  final Color backgroundColor;
  final BorderSide bottomBorder;

  /// Default bar: transparent fill, light bottom divider.
  factory GlyphAppBarStyle.standard() {
    return .new(
      backgroundColor: GlyphColors.surface,
      bottomBorder: BorderSide(color: GlyphColors.border),
    );
  }

  GlyphAppBarStyle copyWith({
    Color? backgroundColor,
    BorderSide? bottomBorder,
  }) {
    return .new(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      bottomBorder: bottomBorder ?? this.bottomBorder,
    );
  }
}
