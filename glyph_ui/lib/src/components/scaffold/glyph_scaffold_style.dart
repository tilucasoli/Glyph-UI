import 'package:flutter/widgets.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_radius.dart';

/// Visual properties for [GlyphScaffold].
///
/// Canvas, content panel surface, and elevation are defined here so the widget
/// does not reference [GlyphColors] directly.
@immutable
final class GlyphScaffoldStyle {
  const GlyphScaffoldStyle({
    required this.canvasColor,
    required this.contentSurfaceColor,
    required this.contentBorderRadius,
    required this.contentShadows,
  });

  final Color canvasColor;
  final Color contentSurfaceColor;
  final BorderRadius contentBorderRadius;
  final List<BoxShadow> contentShadows;

  /// Default shell: canvas background, white rounded panel with soft shadow.
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
    );
  }

  GlyphScaffoldStyle copyWith({
    Color? canvasColor,
    Color? contentSurfaceColor,
    BorderRadius? contentBorderRadius,
    List<BoxShadow>? contentShadows,
  }) {
    return .new(
      canvasColor: canvasColor ?? this.canvasColor,
      contentSurfaceColor: contentSurfaceColor ?? this.contentSurfaceColor,
      contentBorderRadius: contentBorderRadius ?? this.contentBorderRadius,
      contentShadows: contentShadows ?? this.contentShadows,
    );
  }
}
