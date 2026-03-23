import 'package:flutter/widgets.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_radius.dart';

/// Visual properties for [GlyphCard].
///
/// Since a card is a non-interactive wrapper, properties are plain values
/// rather than [WidgetStateProperty].
@immutable
final class GlyphCardStyle {
  const GlyphCardStyle({
    required this.backgroundColor,
    required this.borderSide,
    required this.borderRadius,
    this.shadows = const [],
  });

  final Color backgroundColor;
  final BorderSide borderSide;
  final BorderRadius borderRadius;
  final List<BoxShadow> shadows;

  /// White surface with a subtle shadow and translucent border.
  factory GlyphCardStyle.surface() {
    return .new(
      backgroundColor: GlyphColors.surface,
      borderSide: BorderSide(color: GlyphColors.border),
      borderRadius: GlyphRadius.borderLarge,
      shadows: [
        BoxShadow(
          color: GlyphColors.content.withValues(alpha: 0.02),
          blurRadius: 8,
          offset: const .new(0, 2),
        ),
      ],
    );
  }

  GlyphCardStyle copyWith({
    Color? backgroundColor,
    BorderSide? borderSide,
    BorderRadius? borderRadius,
    List<BoxShadow>? shadows,
  }) {
    return .new(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderSide: borderSide ?? this.borderSide,
      borderRadius: borderRadius ?? this.borderRadius,
      shadows: shadows ?? this.shadows,
    );
  }
}
