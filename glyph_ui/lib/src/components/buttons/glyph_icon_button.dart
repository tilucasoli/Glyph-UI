import 'package:flutter/material.dart';

import '../../tokens/glyph_colors.dart';
import 'glyph_button_style.dart';
import 'glyph_button_theme.dart';

/// An icon-only button styled via [GlyphButtonThemeData] with [variant], [size],
/// optional [style] override, and optional [tooltip].
///
/// Resolves [ButtonStyle] from [GlyphButtonThemeData.styleFor], merges [style],
/// then applies size metrics (square [GlyphButtonStyleMetrics.iconButtonSize],
/// [GlyphButtonStyleMetrics.iconButtonIconSize] for the icon). Uses [FilledButton]
/// for focus and hover behavior.
///
/// ```dart
/// GlyphIconButton(
///   icon: Icon(Icons.search),
///   onPressed: () {},
///   semanticLabel: 'Search',
///   tooltip: 'Search',
/// )
/// ```
final class GlyphIconButton extends StatelessWidget {
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
      padding: .all(.zero),
      minimumSize: .all(Size(metrics.iconButtonSize, metrics.iconButtonSize)),
    );
    final finalStyle = resolved.merge(sizeOverrides);

    final isDisabled = onPressed == null;
    final iconColor = resolved.foregroundColor
            ?.resolve(isDisabled ? const {MaterialState.disabled} : {}) ??
        (isDisabled ? GlyphColors.textTertiary : null);

    final button = Semantics(
      button: true,
      label: semanticLabel,
      child: FilledButton(
        style: finalStyle,
        onPressed: onPressed,
        child: IconTheme(
          data: IconThemeData(
            size: metrics.iconButtonIconSize,
            color: iconColor,
          ),
          child: icon,
        ),
      ),
    );

    if (tooltip != null && tooltip!.isNotEmpty) {
      return Tooltip(message: tooltip!, child: button);
    }
    return button;
  }
}
