import 'package:flutter/widgets.dart';

import '../../tokens/glyph_typography.dart';

/// Dimensional metrics for [GlyphTextField].
///
/// Non-state-dependent sizing: field height, input padding, label typography,
/// and trailing spacing. Use [GlyphTextFieldMetrics.medium] or
/// [GlyphTextFieldMetrics.large].
@immutable
final class GlyphTextFieldMetrics {
  const GlyphTextFieldMetrics({
    required this.minHeight,
    required this.inputContentPadding,
    required this.labelTextStyle,
    required this.inputTextStyle,
    required this.labelBottomSpacing,
    required this.trailingGap,
  });

  /// Minimum height of the bordered input row.
  final double minHeight;

  /// [InputDecoration.contentPadding] for the inner [TextField].
  final EdgeInsets inputContentPadding;

  /// Base style for the label; color comes from [GlyphTextFieldStyle].
  final TextStyle labelTextStyle;

  /// Base style for input text; color comes from [GlyphTextFieldStyle].
  final TextStyle inputTextStyle;

  /// Vertical gap between label and field.
  final double labelBottomSpacing;

  /// Space after optional [GlyphTextField.trailing] widget.
  final double trailingGap;

  factory GlyphTextFieldMetrics.medium() {
    return const GlyphTextFieldMetrics(
      minHeight: 48,
      inputContentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      labelTextStyle: GlyphTextStyles.labelSmallStrong,
      inputTextStyle: GlyphTextStyles.paragraphMedium,
      labelBottomSpacing: 6,
      trailingGap: 12,
    );
  }

  factory GlyphTextFieldMetrics.large() {
    return const GlyphTextFieldMetrics(
      minHeight: 56,
      inputContentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      labelTextStyle: GlyphTextStyles.labelSmallStrong,
      inputTextStyle: GlyphTextStyles.paragraphMedium,
      labelBottomSpacing: 6,
      trailingGap: 12,
    );
  }

  GlyphTextFieldMetrics copyWith({
    double? minHeight,
    EdgeInsets? inputContentPadding,
    TextStyle? labelTextStyle,
    TextStyle? inputTextStyle,
    double? labelBottomSpacing,
    double? trailingGap,
  }) {
    return GlyphTextFieldMetrics(
      minHeight: minHeight ?? this.minHeight,
      inputContentPadding: inputContentPadding ?? this.inputContentPadding,
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      inputTextStyle: inputTextStyle ?? this.inputTextStyle,
      labelBottomSpacing: labelBottomSpacing ?? this.labelBottomSpacing,
      trailingGap: trailingGap ?? this.trailingGap,
    );
  }
}
