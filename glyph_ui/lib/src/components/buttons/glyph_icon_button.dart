import 'package:flutter/material.dart';

import 'glyph_button_style.dart';
import 'glyph_button_theme.dart';

/// Icon-only button that uses [GlyphButtonThemeData] for styling and supports
/// variant, size, optional [style] override, and optional [tooltip].
///
/// Resolves [ButtonStyle] from [GlyphButtonThemeData.styleFor], merges optional
/// [style], then applies size metrics (square [GlyphButtonStyleMetrics.iconButtonSize],
/// [GlyphButtonStyleMetrics.iconButtonIconSize] for the icon). Uses [FilledButton]
/// for focus/hover behavior.
///
/// ```dart
/// GlyphIconButton(
///   icon: Icon(Icons.search),
///   onPressed: () {},
///   semanticLabel: 'Search',
///   tooltip: 'Search',
/// )
/// ```
class GlyphIconButton extends StatelessWidget {
  const GlyphIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.semanticLabel,
    this.variant = GlyphButtonVariant.stroke,
    this.size = GlyphButtonSize.medium,
    this.style,
    this.tooltip,
  });

  final Widget icon;
  final VoidCallback? onPressed;
  final String semanticLabel;
  final GlyphButtonVariant variant;
  final GlyphButtonSize size;
  final ButtonStyle? style;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final themeData = GlyphButtonThemeData.of(context);
    final base = themeData.styleFor(variant);
    final resolved = style != null ? base.merge(style!) : base;

    final metrics = GlyphButtonStyleMetrics.forSize(size);
    final sizeOverrides = ButtonStyle(
      padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.zero),
      minimumSize: WidgetStatePropertyAll<Size>(
        Size(metrics.iconButtonSize, metrics.iconButtonSize),
      ),
    );
    final finalStyle = resolved.merge(sizeOverrides);

    final button = Semantics(
      button: true,
      label: semanticLabel,
      child: FilledButton(
        style: finalStyle,
        onPressed: onPressed,
        child: IconTheme(
          data: IconThemeData(size: metrics.iconButtonIconSize),
          child: icon,
        ),
      ),
    );

    if (tooltip != null && tooltip!.isNotEmpty) {
      return Tooltip(
        message: tooltip!,
        child: button,
      );
    }
    return button;
  }
}
