import 'package:flutter/material.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_radius.dart';
import '../../tokens/glyph_spacing.dart';
import '../../tokens/glyph_typography.dart';
import '../../utils/widget_size_property.dart';
import 'glyph_sidebar_item_style.dart';

/// Preset sizes for [GlyphSidebar] layout (single preset today).
enum GlyphSidebarSize {
  medium,
}

/// Visual and layout properties for [GlyphSidebar].
///
/// Panel chrome uses plain values. Nav rows use [GlyphSidebarItemStyle]. Layout
/// uses [WidgetCustomProperty] keyed by [GlyphSidebarSize].
@immutable
final class GlyphSidebarStyle {
  GlyphSidebarStyle({
    required this.sidebarBackgroundColor,
    required this.sidebarBorderRadius,
    required this.sidebarShadows,
    required this.footerTopBorderColor,
    required this.navGroupTitleStyle,
    required this.itemStyle,
    required this.width,
    required this.brandPadding,
    required this.footerPadding,
    required this.navGroupVerticalPadding,
    required this.navGroupTitleHorizontalPadding,
    required this.navItemsHorizontalPadding,
    required this.navItemPadding,
    required this.navItemBottomMargin,
    required this.navItemIconSize,
    required this.navItemIconGap,
  });

  static final WidgetCustomProperty<double, GlyphSidebarSize> _defaultWidth =
      WidgetCustomProperty.resolveWith((_) => 260);

  static final WidgetCustomProperty<EdgeInsets, GlyphSidebarSize>
      _defaultBrandPadding = WidgetCustomProperty.resolveWith(
    (_) => const EdgeInsets.fromLTRB(20, Spacing.x6, 20, Spacing.x4),
  );

  static final WidgetCustomProperty<EdgeInsets, GlyphSidebarSize>
      _defaultFooterPadding = WidgetCustomProperty.resolveWith(
    (_) => const EdgeInsets.all(Spacing.x4),
  );

  static final WidgetCustomProperty<EdgeInsets, GlyphSidebarSize>
      _defaultNavGroupVerticalPadding = WidgetCustomProperty.resolveWith(
    (_) => const EdgeInsets.only(top: Spacing.x2, bottom: Spacing.x2),
  );

  static final WidgetCustomProperty<double, GlyphSidebarSize>
      _defaultNavGroupTitleHorizontalPadding =
      WidgetCustomProperty.resolveWith((_) => Spacing.x6);

  static final WidgetCustomProperty<double, GlyphSidebarSize>
      _defaultNavItemsHorizontalPadding =
      WidgetCustomProperty.resolveWith((_) => Spacing.x3);

  static final WidgetCustomProperty<EdgeInsets, GlyphSidebarSize>
      _defaultNavItemPadding = WidgetCustomProperty.resolveWith(
    (_) => const EdgeInsets.symmetric(
      horizontal: Spacing.x3,
      vertical: Spacing.x2,
    ),
  );

  static final WidgetCustomProperty<double, GlyphSidebarSize>
      _defaultNavItemBottomMargin =
      WidgetCustomProperty.resolveWith((_) => 2);

  static final WidgetCustomProperty<double, GlyphSidebarSize>
      _defaultNavItemIconSize = WidgetCustomProperty.resolveWith((_) => 18);

  static final WidgetCustomProperty<double, GlyphSidebarSize>
      _defaultNavItemIconGap = WidgetCustomProperty.resolveWith((_) => Spacing.x3);

  final Color sidebarBackgroundColor;
  final BorderRadius sidebarBorderRadius;
  final List<BoxShadow> sidebarShadows;
  final Color footerTopBorderColor;
  final TextStyle navGroupTitleStyle;
  final GlyphSidebarItemStyle itemStyle;

  final WidgetCustomProperty<double, GlyphSidebarSize> width;
  final WidgetCustomProperty<EdgeInsets, GlyphSidebarSize> brandPadding;
  final WidgetCustomProperty<EdgeInsets, GlyphSidebarSize> footerPadding;
  final WidgetCustomProperty<EdgeInsets, GlyphSidebarSize> navGroupVerticalPadding;
  final WidgetCustomProperty<double, GlyphSidebarSize> navGroupTitleHorizontalPadding;
  final WidgetCustomProperty<double, GlyphSidebarSize> navItemsHorizontalPadding;
  final WidgetCustomProperty<EdgeInsets, GlyphSidebarSize> navItemPadding;
  final WidgetCustomProperty<double, GlyphSidebarSize> navItemBottomMargin;
  final WidgetCustomProperty<double, GlyphSidebarSize> navItemIconSize;
  final WidgetCustomProperty<double, GlyphSidebarSize> navItemIconGap;

  factory GlyphSidebarStyle.standard() {
    return .new(
      sidebarBackgroundColor: GlyphColors.surface,
      sidebarBorderRadius: GlyphRadius.borderLarge,
      sidebarShadows: [
        BoxShadow(
          color: GlyphColors.content.withValues(alpha: 0.05),
          blurRadius: 25,
          offset: const Offset(0, 10),
          spreadRadius: -5,
        ),
      ],
      footerTopBorderColor: GlyphColors.borderStrong,
      navGroupTitleStyle: GlyphTextStyles.labelXsmallStrong.copyWith(
        color: GlyphColors.contentDisabled,
      ),
      itemStyle: GlyphSidebarItemStyle.standard(),
      width: _defaultWidth,
      brandPadding: _defaultBrandPadding,
      footerPadding: _defaultFooterPadding,
      navGroupVerticalPadding: _defaultNavGroupVerticalPadding,
      navGroupTitleHorizontalPadding: _defaultNavGroupTitleHorizontalPadding,
      navItemsHorizontalPadding: _defaultNavItemsHorizontalPadding,
      navItemPadding: _defaultNavItemPadding,
      navItemBottomMargin: _defaultNavItemBottomMargin,
      navItemIconSize: _defaultNavItemIconSize,
      navItemIconGap: _defaultNavItemIconGap,
    );
  }

  GlyphSidebarStyle copyWith({
    Color? sidebarBackgroundColor,
    BorderRadius? sidebarBorderRadius,
    List<BoxShadow>? sidebarShadows,
    Color? footerTopBorderColor,
    TextStyle? navGroupTitleStyle,
    GlyphSidebarItemStyle? itemStyle,
    WidgetCustomProperty<double, GlyphSidebarSize>? width,
    WidgetCustomProperty<EdgeInsets, GlyphSidebarSize>? brandPadding,
    WidgetCustomProperty<EdgeInsets, GlyphSidebarSize>? footerPadding,
    WidgetCustomProperty<EdgeInsets, GlyphSidebarSize>? navGroupVerticalPadding,
    WidgetCustomProperty<double, GlyphSidebarSize>? navGroupTitleHorizontalPadding,
    WidgetCustomProperty<double, GlyphSidebarSize>? navItemsHorizontalPadding,
    WidgetCustomProperty<EdgeInsets, GlyphSidebarSize>? navItemPadding,
    WidgetCustomProperty<double, GlyphSidebarSize>? navItemBottomMargin,
    WidgetCustomProperty<double, GlyphSidebarSize>? navItemIconSize,
    WidgetCustomProperty<double, GlyphSidebarSize>? navItemIconGap,
  }) {
    return .new(
      sidebarBackgroundColor:
          sidebarBackgroundColor ?? this.sidebarBackgroundColor,
      sidebarBorderRadius: sidebarBorderRadius ?? this.sidebarBorderRadius,
      sidebarShadows: sidebarShadows ?? this.sidebarShadows,
      footerTopBorderColor: footerTopBorderColor ?? this.footerTopBorderColor,
      navGroupTitleStyle: navGroupTitleStyle ?? this.navGroupTitleStyle,
      itemStyle: itemStyle ?? this.itemStyle,
      width: width ?? this.width,
      brandPadding: brandPadding ?? this.brandPadding,
      footerPadding: footerPadding ?? this.footerPadding,
      navGroupVerticalPadding:
          navGroupVerticalPadding ?? this.navGroupVerticalPadding,
      navGroupTitleHorizontalPadding: navGroupTitleHorizontalPadding ??
          this.navGroupTitleHorizontalPadding,
      navItemsHorizontalPadding:
          navItemsHorizontalPadding ?? this.navItemsHorizontalPadding,
      navItemPadding: navItemPadding ?? this.navItemPadding,
      navItemBottomMargin: navItemBottomMargin ?? this.navItemBottomMargin,
      navItemIconSize: navItemIconSize ?? this.navItemIconSize,
      navItemIconGap: navItemIconGap ?? this.navItemIconGap,
    );
  }
}
