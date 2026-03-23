import 'package:flutter/widgets.dart';

import 'glyph_card_metrics.dart';
import 'glyph_card_style.dart';

/// A non-interactive surface wrapper with background, border, and shadow.
///
/// ```dart
/// GlyphCard(
///   style: GlyphCardStyle.surface(),
///   metrics: GlyphCardMetrics.large(),
///   child: Column(...),
/// )
/// ```
final class GlyphCard extends StatelessWidget {
  const GlyphCard({
    super.key,
    required this.child,
    required this.style,
    this.metrics,
  });

  final Widget child;
  final GlyphCardStyle style;

  /// Defaults to [GlyphCardMetrics.medium] when omitted.
  final GlyphCardMetrics? metrics;

  @override
  Widget build(BuildContext context) {
    final m = metrics ?? .medium();

    return DecoratedBox(
      decoration: BoxDecoration(
        color: style.backgroundColor,
        borderRadius: style.borderRadius,
        border: Border.fromBorderSide(style.borderSide),
        boxShadow: style.shadows,
      ),
      child: Padding(padding: m.padding, child: child),
    );
  }
}
