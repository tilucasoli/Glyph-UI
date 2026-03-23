import 'package:flutter/material.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_radius.dart';
import '../../tokens/glyph_typography.dart';
import 'glyph_sidebar_item_style.dart';

/// Visual properties for [GlyphSidebar].
///
/// Panel chrome uses plain values. Nav rows use [GlyphSidebarItemStyle].
@immutable
final class GlyphSidebarStyle {
  const GlyphSidebarStyle({
    required this.sidebarBackgroundColor,
    required this.sidebarBorderRadius,
    required this.sidebarShadows,
    required this.footerTopBorderColor,
    required this.navGroupTitleStyle,
    required this.itemStyle,
  });

  final Color sidebarBackgroundColor;
  final BorderRadius sidebarBorderRadius;
  final List<BoxShadow> sidebarShadows;
  final Color footerTopBorderColor;
  final TextStyle navGroupTitleStyle;

  /// Appearance of each navigation row ([GlyphSidebarItemTile]).
  final GlyphSidebarItemStyle itemStyle;

  /// Default sidebar from the design reference.
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
    );
  }

  GlyphSidebarStyle copyWith({
    Color? sidebarBackgroundColor,
    BorderRadius? sidebarBorderRadius,
    List<BoxShadow>? sidebarShadows,
    Color? footerTopBorderColor,
    TextStyle? navGroupTitleStyle,
    GlyphSidebarItemStyle? itemStyle,
  }) {
    return .new(
      sidebarBackgroundColor:
          sidebarBackgroundColor ?? this.sidebarBackgroundColor,
      sidebarBorderRadius: sidebarBorderRadius ?? this.sidebarBorderRadius,
      sidebarShadows: sidebarShadows ?? this.sidebarShadows,
      footerTopBorderColor: footerTopBorderColor ?? this.footerTopBorderColor,
      navGroupTitleStyle: navGroupTitleStyle ?? this.navGroupTitleStyle,
      itemStyle: itemStyle ?? this.itemStyle,
    );
  }
}
