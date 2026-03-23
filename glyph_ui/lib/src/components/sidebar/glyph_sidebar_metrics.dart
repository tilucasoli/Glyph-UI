import 'package:flutter/widgets.dart';

import '../../tokens/glyph_spacing.dart';
import '../../tokens/glyph_typography.dart';

/// Dimensional metrics for [GlyphSidebar].
@immutable
final class GlyphSidebarMetrics {
  const GlyphSidebarMetrics({
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
    required this.navItemLabelBaseStyle,
  });

  final double width;
  final EdgeInsets brandPadding;
  final EdgeInsets footerPadding;
  final EdgeInsets navGroupVerticalPadding;
  final double navGroupTitleHorizontalPadding;
  final double navItemsHorizontalPadding;
  final EdgeInsets navItemPadding;
  final double navItemBottomMargin;
  final double navItemIconSize;
  final double navItemIconGap;
  final TextStyle navItemLabelBaseStyle;

  /// Matches the design reference (260px rail, spacing from tokens).
  factory GlyphSidebarMetrics.medium() {
    return .new(
      width: 260,
      brandPadding: const EdgeInsets.fromLTRB(
        20,
        Spacing.x6,
        20,
        Spacing.x4,
      ),
      footerPadding: const EdgeInsets.all(Spacing.x4),
      navGroupVerticalPadding: const EdgeInsets.only(
        top: Spacing.x2,
        bottom: Spacing.x2,
      ),
      navGroupTitleHorizontalPadding: Spacing.x6,
      navItemsHorizontalPadding: Spacing.x3,
      navItemPadding: const EdgeInsets.symmetric(
        horizontal: Spacing.x3,
        vertical: Spacing.x2,
      ),
      navItemBottomMargin: 2,
      navItemIconSize: 18,
      navItemIconGap: Spacing.x3,
      navItemLabelBaseStyle: GlyphTextStyles.labelSmallStrong,
    );
  }

  GlyphSidebarMetrics copyWith({
    double? width,
    EdgeInsets? brandPadding,
    EdgeInsets? footerPadding,
    EdgeInsets? navGroupVerticalPadding,
    double? navGroupTitleHorizontalPadding,
    double? navItemsHorizontalPadding,
    EdgeInsets? navItemPadding,
    double? navItemBottomMargin,
    double? navItemIconSize,
    double? navItemIconGap,
    TextStyle? navItemLabelBaseStyle,
  }) {
    return .new(
      width: width ?? this.width,
      brandPadding: brandPadding ?? this.brandPadding,
      footerPadding: footerPadding ?? this.footerPadding,
      navGroupVerticalPadding: navGroupVerticalPadding ?? this.navGroupVerticalPadding,
      navGroupTitleHorizontalPadding:
          navGroupTitleHorizontalPadding ?? this.navGroupTitleHorizontalPadding,
      navItemsHorizontalPadding:
          navItemsHorizontalPadding ?? this.navItemsHorizontalPadding,
      navItemPadding: navItemPadding ?? this.navItemPadding,
      navItemBottomMargin: navItemBottomMargin ?? this.navItemBottomMargin,
      navItemIconSize: navItemIconSize ?? this.navItemIconSize,
      navItemIconGap: navItemIconGap ?? this.navItemIconGap,
      navItemLabelBaseStyle: navItemLabelBaseStyle ?? this.navItemLabelBaseStyle,
    );
  }
}
