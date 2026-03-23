import 'package:flutter/widgets.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_radius.dart';
import '../../tokens/glyph_spacing.dart';
import '../../utils/widget_size_property.dart';

/// Preset sizes for [GlyphScaffold] layout (single preset today).
enum GlyphScaffoldSize {
  medium,
}

/// Visual and layout properties for [GlyphScaffold].
///
/// Canvas, content panel surface, and elevation are defined here so the widget
/// does not reference [GlyphColors] directly. Layout uses [WidgetCustomProperty]
/// keyed by [GlyphScaffoldSize].
@immutable
final class GlyphScaffoldStyle {
  GlyphScaffoldStyle({
    required this.canvasColor,
    required this.contentSurfaceColor,
    required this.contentBorderRadius,
    required this.contentShadows,
    required this.outerPadding,
    required this.sidebarContentGap,
  });

  static final WidgetCustomProperty<EdgeInsets, GlyphScaffoldSize>
      _defaultOuterPadding = WidgetCustomProperty.resolveWith(
    (_) => const EdgeInsets.all(Spacing.x4),
  );

  static final WidgetCustomProperty<double, GlyphScaffoldSize>
      _defaultSidebarContentGap =
      WidgetCustomProperty.resolveWith((_) => Spacing.x4);

  final Color canvasColor;
  final Color contentSurfaceColor;
  final BorderRadius contentBorderRadius;
  final List<BoxShadow> contentShadows;

  final WidgetCustomProperty<EdgeInsets, GlyphScaffoldSize> outerPadding;
  final WidgetCustomProperty<double, GlyphScaffoldSize> sidebarContentGap;

  factory GlyphScaffoldStyle.standard() {
    return .new(
      canvasColor: GlyphColors.background,
      contentSurfaceColor: GlyphColors.surface,
      contentBorderRadius: GlyphRadius.borderLarge,
      contentShadows: [
        BoxShadow(
          color: GlyphColors.content.withValues(alpha: 0.05),
          blurRadius: 25,
          offset: const Offset(0, 10),
          spreadRadius: -5,
        ),
      ],
      outerPadding: _defaultOuterPadding,
      sidebarContentGap: _defaultSidebarContentGap,
    );
  }

  GlyphScaffoldStyle copyWith({
    Color? canvasColor,
    Color? contentSurfaceColor,
    BorderRadius? contentBorderRadius,
    List<BoxShadow>? contentShadows,
    WidgetCustomProperty<EdgeInsets, GlyphScaffoldSize>? outerPadding,
    WidgetCustomProperty<double, GlyphScaffoldSize>? sidebarContentGap,
  }) {
    return .new(
      canvasColor: canvasColor ?? this.canvasColor,
      contentSurfaceColor: contentSurfaceColor ?? this.contentSurfaceColor,
      contentBorderRadius: contentBorderRadius ?? this.contentBorderRadius,
      contentShadows: contentShadows ?? this.contentShadows,
      outerPadding: outerPadding ?? this.outerPadding,
      sidebarContentGap: sidebarContentGap ?? this.sidebarContentGap,
    );
  }
}
