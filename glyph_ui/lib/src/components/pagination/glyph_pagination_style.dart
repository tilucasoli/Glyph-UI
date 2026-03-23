import 'package:flutter/widgets.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_typography.dart';
import '../../utils/widget_size_property.dart';

/// Preset sizes for [GlyphPagination] layout.
enum GlyphPaginationSize {
  small,
  medium,
}

/// Visual and layout properties for [GlyphPagination].
///
/// Bar chrome uses plain colors. Page buttons are [GlyphButton] and carry
/// their own style. Layout uses [WidgetCustomProperty] keyed by
/// [GlyphPaginationSize].
@immutable
final class GlyphPaginationStyle {
  GlyphPaginationStyle({
    required this.barBackgroundColor,
    required this.barTopBorderSide,
    required this.summaryTextColor,
    required this.barPadding,
    required this.pageButtonGap,
    required this.summaryLabelStyle,
  });

  static final WidgetCustomProperty<EdgeInsets, GlyphPaginationSize>
      _defaultBarPadding = WidgetCustomProperty.resolveWith(
    (size) => switch (size) {
      .small => const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      .medium => const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    },
  );

  static final WidgetCustomProperty<double, GlyphPaginationSize>
      _defaultPageButtonGap = WidgetCustomProperty.resolveWith(
    (size) => switch (size) {
      .small => 6,
      .medium => 8,
    },
  );

  static final WidgetCustomProperty<TextStyle, GlyphPaginationSize>
      _defaultSummaryLabelStyle = WidgetCustomProperty.resolveWith(
    (_) => GlyphTextStyles.labelXsmall,
  );

  final Color barBackgroundColor;
  final BorderSide barTopBorderSide;
  final Color summaryTextColor;

  final WidgetCustomProperty<EdgeInsets, GlyphPaginationSize> barPadding;
  final WidgetCustomProperty<double, GlyphPaginationSize> pageButtonGap;
  final WidgetCustomProperty<TextStyle, GlyphPaginationSize> summaryLabelStyle;

  factory GlyphPaginationStyle.standard() {
    return .new(
      barBackgroundColor: GlyphColors.surface,
      barTopBorderSide: BorderSide(color: GlyphColors.border),
      summaryTextColor: GlyphColors.contentSubtle,
      barPadding: _defaultBarPadding,
      pageButtonGap: _defaultPageButtonGap,
      summaryLabelStyle: _defaultSummaryLabelStyle,
    );
  }

  GlyphPaginationStyle copyWith({
    Color? barBackgroundColor,
    BorderSide? barTopBorderSide,
    Color? summaryTextColor,
    WidgetCustomProperty<EdgeInsets, GlyphPaginationSize>? barPadding,
    WidgetCustomProperty<double, GlyphPaginationSize>? pageButtonGap,
    WidgetCustomProperty<TextStyle, GlyphPaginationSize>? summaryLabelStyle,
  }) {
    return .new(
      barBackgroundColor: barBackgroundColor ?? this.barBackgroundColor,
      barTopBorderSide: barTopBorderSide ?? this.barTopBorderSide,
      summaryTextColor: summaryTextColor ?? this.summaryTextColor,
      barPadding: barPadding ?? this.barPadding,
      pageButtonGap: pageButtonGap ?? this.pageButtonGap,
      summaryLabelStyle: summaryLabelStyle ?? this.summaryLabelStyle,
    );
  }
}
