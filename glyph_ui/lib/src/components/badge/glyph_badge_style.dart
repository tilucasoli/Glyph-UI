import 'package:flutter/widgets.dart';
import 'package:glyph_ui/glyph_ui.dart';

/// Visual properties for [GlyphBadge].
///
/// Since a badge is a non-interactive display element, properties are plain
/// values rather than [WidgetStateProperty].
@immutable
final class GlyphBadgeStyle {
  const GlyphBadgeStyle({
    required this.backgroundColor,
    required this.foregroundColor,
    this.borderSide = BorderSide.none,
    this.borderRadius = GlyphRadius.borderMedium,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final BorderSide borderSide;
  final BorderRadius borderRadius;

  /// Dark solid accent badge — white text on dark background.
  const GlyphBadgeStyle.accent()
    : this(
        backgroundColor: GlyphColors.accentPrimary,
        foregroundColor: GlyphColors.surface,
      );

  /// Neutral muted badge — secondary text on light gray.
  const GlyphBadgeStyle.neutral()
    : this(
        backgroundColor: GlyphColors.border,
        foregroundColor: GlyphColors.contentSubtle,
      );

  /// Success / confirmed badge — green tint.
  const GlyphBadgeStyle.success()
    : this(
        backgroundColor: GlyphColors.feedbackSuccessContainer,
        foregroundColor: GlyphColors.feedbackSuccess,
      );

  /// Attention / warning badge — amber tint.
  const GlyphBadgeStyle.attention()
    : this(
        backgroundColor: GlyphColors.feedbackAttentionContainer,
        foregroundColor: GlyphColors.feedbackAttention,
      );

  /// Critical / error badge — red tint.
  const GlyphBadgeStyle.critical()
    : this(
        backgroundColor: GlyphColors.feedbackErrorContainer,
        foregroundColor: GlyphColors.feedbackError,
      );

  GlyphBadgeStyle copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    BorderSide? borderSide,
  }) {
    return .new(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      borderSide: borderSide ?? this.borderSide,
    );
  }
}
