import 'package:flutter/widgets.dart';

import 'glyph_card_style.dart';

/// A non-interactive surface wrapper with background, border, and shadow.
///
/// ```dart
/// GlyphCard(
///   style: GlyphCardStyle.surface(),
///   size: .large,
///   child: Column(...),
/// )
/// ```
final class GlyphCard extends StatelessWidget {
  const GlyphCard({
    super.key,
    required this.child,
    required this.style,
    this.size = GlyphCardSize.medium,
  });

  final Widget child;
  final GlyphCardStyle style;
  final GlyphCardSize size;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: style.backgroundColor,
        borderRadius: style.borderRadius,
        border: Border.fromBorderSide(style.borderSide),
        boxShadow: style.shadows,
      ),
      child: Padding(padding: style.padding.resolve(size), child: child),
    );
  }
}
