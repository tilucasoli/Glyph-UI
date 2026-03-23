import 'package:flutter/widgets.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_typography.dart';
import '../../utils/widget_size_property.dart';

/// Preset sizes for [GlyphBreadcrumbs] layout.
enum GlyphBreadcrumbsSize {
  small,
  medium,
}

/// Visual and layout properties for [GlyphBreadcrumbs].
///
/// Segment colors are plain values. Layout uses [WidgetCustomProperty] keyed
/// by [GlyphBreadcrumbsSize].
@immutable
final class GlyphBreadcrumbsStyle {
  GlyphBreadcrumbsStyle({
    required this.ancestorTextColor,
    required this.currentTextColor,
    required this.separatorIconColor,
    required this.ancestorSegmentStyle,
    required this.currentSegmentStyle,
    required this.chevronSize,
    required this.chevronHorizontalGutter,
  });

  static final WidgetCustomProperty<TextStyle, GlyphBreadcrumbsSize>
      _defaultAncestorSegmentStyle = WidgetCustomProperty.resolveWith(
    (_) => GlyphTextStyles.labelSmall,
  );

  static final WidgetCustomProperty<TextStyle, GlyphBreadcrumbsSize>
      _defaultCurrentSegmentStyle = WidgetCustomProperty.resolveWith(
    (_) => GlyphTextStyles.labelSmallStrong,
  );

  static final WidgetCustomProperty<double, GlyphBreadcrumbsSize>
      _defaultChevronSize = WidgetCustomProperty.resolveWith(
    (size) => switch (size) {
      .small => 10,
      .medium => 12,
    },
  );

  static final WidgetCustomProperty<double, GlyphBreadcrumbsSize>
      _defaultChevronHorizontalGutter = WidgetCustomProperty.resolveWith(
    (size) => switch (size) {
      .small => 6,
      .medium => 8,
    },
  );

  final Color ancestorTextColor;
  final Color currentTextColor;
  final Color separatorIconColor;

  final WidgetCustomProperty<TextStyle, GlyphBreadcrumbsSize> ancestorSegmentStyle;
  final WidgetCustomProperty<TextStyle, GlyphBreadcrumbsSize> currentSegmentStyle;
  final WidgetCustomProperty<double, GlyphBreadcrumbsSize> chevronSize;
  final WidgetCustomProperty<double, GlyphBreadcrumbsSize> chevronHorizontalGutter;

  factory GlyphBreadcrumbsStyle.standard() {
    return .new(
      ancestorTextColor: GlyphColors.contentSubtle,
      currentTextColor: GlyphColors.content,
      separatorIconColor: GlyphColors.contentDisabled,
      ancestorSegmentStyle: _defaultAncestorSegmentStyle,
      currentSegmentStyle: _defaultCurrentSegmentStyle,
      chevronSize: _defaultChevronSize,
      chevronHorizontalGutter: _defaultChevronHorizontalGutter,
    );
  }

  GlyphBreadcrumbsStyle copyWith({
    Color? ancestorTextColor,
    Color? currentTextColor,
    Color? separatorIconColor,
    WidgetCustomProperty<TextStyle, GlyphBreadcrumbsSize>? ancestorSegmentStyle,
    WidgetCustomProperty<TextStyle, GlyphBreadcrumbsSize>? currentSegmentStyle,
    WidgetCustomProperty<double, GlyphBreadcrumbsSize>? chevronSize,
    WidgetCustomProperty<double, GlyphBreadcrumbsSize>? chevronHorizontalGutter,
  }) {
    return .new(
      ancestorTextColor: ancestorTextColor ?? this.ancestorTextColor,
      currentTextColor: currentTextColor ?? this.currentTextColor,
      separatorIconColor: separatorIconColor ?? this.separatorIconColor,
      ancestorSegmentStyle:
          ancestorSegmentStyle ?? this.ancestorSegmentStyle,
      currentSegmentStyle: currentSegmentStyle ?? this.currentSegmentStyle,
      chevronSize: chevronSize ?? this.chevronSize,
      chevronHorizontalGutter:
          chevronHorizontalGutter ?? this.chevronHorizontalGutter,
    );
  }
}
