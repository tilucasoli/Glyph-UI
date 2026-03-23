import 'package:flutter/widgets.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_spacing.dart';
import '../../tokens/glyph_typography.dart';
import '../../utils/widget_size_property.dart';

/// Preset sizes for [GlyphAppBar] layout (single preset today).
enum GlyphAppBarSize {
  medium,
}

/// Visual and layout properties for [GlyphAppBar].
///
/// The app bar is non-interactive chrome; values are plain fields except
/// layout, which uses [WidgetCustomProperty] keyed by [GlyphAppBarSize].
@immutable
final class GlyphAppBarStyle {
  GlyphAppBarStyle({
    required this.backgroundColor,
    required this.bottomBorder,
    required this.padding,
    required this.minHeight,
    required this.titleTextStyle,
    required this.breadcrumbTitleGap,
    required this.actionSpacing,
  });

  static final WidgetCustomProperty<EdgeInsets, GlyphAppBarSize> _defaultPadding =
      WidgetCustomProperty.resolveWith(
    (_) => const EdgeInsets.symmetric(
      horizontal: Spacing.x8,
      vertical: Spacing.x4,
    ),
  );

  static final WidgetCustomProperty<double, GlyphAppBarSize> _defaultMinHeight =
      WidgetCustomProperty.resolveWith((_) => 70);

  static final WidgetCustomProperty<TextStyle, GlyphAppBarSize>
      _defaultTitleTextStyle = WidgetCustomProperty.resolveWith(
    (_) => GlyphTextStyles.titleXsmall,
  );

  static final WidgetCustomProperty<double, GlyphAppBarSize>
      _defaultBreadcrumbTitleGap =
      WidgetCustomProperty.resolveWith((_) => Spacing.x2);

  static final WidgetCustomProperty<double, GlyphAppBarSize>
      _defaultActionSpacing = WidgetCustomProperty.resolveWith((_) => Spacing.x2);

  final Color backgroundColor;
  final BorderSide bottomBorder;

  final WidgetCustomProperty<EdgeInsets, GlyphAppBarSize> padding;
  final WidgetCustomProperty<double, GlyphAppBarSize> minHeight;
  final WidgetCustomProperty<TextStyle, GlyphAppBarSize> titleTextStyle;
  final WidgetCustomProperty<double, GlyphAppBarSize> breadcrumbTitleGap;
  final WidgetCustomProperty<double, GlyphAppBarSize> actionSpacing;

  factory GlyphAppBarStyle.standard() {
    return .new(
      backgroundColor: GlyphColors.surface,
      bottomBorder: BorderSide(color: GlyphColors.border),
      padding: _defaultPadding,
      minHeight: _defaultMinHeight,
      titleTextStyle: _defaultTitleTextStyle,
      breadcrumbTitleGap: _defaultBreadcrumbTitleGap,
      actionSpacing: _defaultActionSpacing,
    );
  }

  GlyphAppBarStyle copyWith({
    Color? backgroundColor,
    BorderSide? bottomBorder,
    WidgetCustomProperty<EdgeInsets, GlyphAppBarSize>? padding,
    WidgetCustomProperty<double, GlyphAppBarSize>? minHeight,
    WidgetCustomProperty<TextStyle, GlyphAppBarSize>? titleTextStyle,
    WidgetCustomProperty<double, GlyphAppBarSize>? breadcrumbTitleGap,
    WidgetCustomProperty<double, GlyphAppBarSize>? actionSpacing,
  }) {
    return .new(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      bottomBorder: bottomBorder ?? this.bottomBorder,
      padding: padding ?? this.padding,
      minHeight: minHeight ?? this.minHeight,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      breadcrumbTitleGap: breadcrumbTitleGap ?? this.breadcrumbTitleGap,
      actionSpacing: actionSpacing ?? this.actionSpacing,
    );
  }
}
