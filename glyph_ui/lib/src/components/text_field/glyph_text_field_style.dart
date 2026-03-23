import 'package:flutter/widgets.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_typography.dart';
import '../../utils/widget_size_property.dart';

/// Preset sizes for [GlyphTextField] layout.
enum GlyphTextFieldSize {
  medium,
  large,
}

/// Style for [GlyphTextField]: interaction state visuals and size-keyed layout.
///
/// State-dependent values resolve against the field's internal
/// [WidgetStatesController]. Layout uses [WidgetCustomProperty] keyed by
/// [GlyphTextFieldSize].
@immutable
final class GlyphTextFieldStyle {
  GlyphTextFieldStyle({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.hintColor,
    required this.shape,
    required this.inputContentPadding,
    required this.labelTextStyle,
    required this.inputTextStyle,
    required this.labelBottomSpacing,
    required this.trailingGap,
    this.shadows = const WidgetStatePropertyAll([]),
    this.animationDuration = const .new(milliseconds: 150),
    this.animationCurve = Curves.easeOut,
  });

  static final WidgetCustomProperty<EdgeInsets, GlyphTextFieldSize>
      _defaultInputContentPadding = WidgetCustomProperty.resolveWith(
    (size) => switch (size) {
      .medium => const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      .large => const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
    },
  );

  static final WidgetCustomProperty<TextStyle, GlyphTextFieldSize>
      _defaultLabelTextStyle = WidgetCustomProperty.resolveWith(
    (_) => GlyphTextStyles.labelSmallStrong,
  );

  static final WidgetCustomProperty<TextStyle, GlyphTextFieldSize>
      _defaultInputTextStyle = WidgetCustomProperty.resolveWith(
    (_) => GlyphTextStyles.paragraphMedium,
  );

  static final WidgetCustomProperty<double, GlyphTextFieldSize>
      _defaultLabelBottomSpacing = WidgetCustomProperty.resolveWith((_) => 6);

  static final WidgetCustomProperty<double, GlyphTextFieldSize>
      _defaultTrailingGap = WidgetCustomProperty.resolveWith((_) => 12);

  final WidgetStateProperty<Color> backgroundColor;
  final WidgetStateProperty<Color> foregroundColor;
  final WidgetStateProperty<Color> hintColor;
  final WidgetStateProperty<OutlinedBorder> shape;
  final WidgetStateProperty<List<BoxShadow>> shadows;
  final Duration animationDuration;
  final Curve animationCurve;

  final WidgetCustomProperty<EdgeInsets, GlyphTextFieldSize> inputContentPadding;
  final WidgetCustomProperty<TextStyle, GlyphTextFieldSize> labelTextStyle;
  final WidgetCustomProperty<TextStyle, GlyphTextFieldSize> inputTextStyle;
  final WidgetCustomProperty<double, GlyphTextFieldSize> labelBottomSpacing;
  final WidgetCustomProperty<double, GlyphTextFieldSize> trailingGap;

  factory GlyphTextFieldStyle.stroke() {
    return .new(
      backgroundColor: .resolveWith((states) {
        return GlyphColors.surface;
      }),
      foregroundColor: .resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return GlyphColors.contentDisabled;
        }
        return GlyphColors.content;
      }),
      hintColor: const WidgetStatePropertyAll(GlyphColors.contentSubtle),
      shape: .resolveWith((states) {
        final sideColor = _borderColorFor(states);
        return RoundedRectangleBorder(
          borderRadius: .circular(8),
          side: BorderSide(color: sideColor),
        );
      }),
      inputContentPadding: _defaultInputContentPadding,
      labelTextStyle: _defaultLabelTextStyle,
      inputTextStyle: _defaultInputTextStyle,
      labelBottomSpacing: _defaultLabelBottomSpacing,
      trailingGap: _defaultTrailingGap,
    );
  }

  static Color _borderColorFor(Set<WidgetState> states) {
    if (states.contains(WidgetState.disabled)) {
      return GlyphColors.borderStrong;
    }
    if (states.contains(WidgetState.focused)) {
      return GlyphColors.borderStrong;
    }
    return GlyphColors.border;
  }

  GlyphTextFieldStyle copyWith({
    WidgetStateProperty<Color>? backgroundColor,
    WidgetStateProperty<Color>? foregroundColor,
    WidgetStateProperty<Color>? hintColor,
    WidgetStateProperty<OutlinedBorder>? shape,
    WidgetStateProperty<List<BoxShadow>>? shadows,
    Duration? animationDuration,
    Curve? animationCurve,
    WidgetCustomProperty<EdgeInsets, GlyphTextFieldSize>? inputContentPadding,
    WidgetCustomProperty<TextStyle, GlyphTextFieldSize>? labelTextStyle,
    WidgetCustomProperty<TextStyle, GlyphTextFieldSize>? inputTextStyle,
    WidgetCustomProperty<double, GlyphTextFieldSize>? labelBottomSpacing,
    WidgetCustomProperty<double, GlyphTextFieldSize>? trailingGap,
  }) {
    return .new(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      hintColor: hintColor ?? this.hintColor,
      shape: shape ?? this.shape,
      shadows: shadows ?? this.shadows,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      inputContentPadding: inputContentPadding ?? this.inputContentPadding,
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      inputTextStyle: inputTextStyle ?? this.inputTextStyle,
      labelBottomSpacing: labelBottomSpacing ?? this.labelBottomSpacing,
      trailingGap: trailingGap ?? this.trailingGap,
    );
  }
}
