import 'package:flutter/widgets.dart';

/// Dimensional metrics for [GlyphIconButton].
///
/// Holds the square button dimension and icon size.
/// Use factory constructors for standard size presets.
@immutable
final class GlyphIconButtonMetrics {
  const GlyphIconButtonMetrics({
    required this.buttonSize,
    required this.iconSize,
  });

  final double buttonSize;
  final double iconSize;

  factory GlyphIconButtonMetrics.medium() {
    return const .new(buttonSize: 40, iconSize: 20);
  }

  factory GlyphIconButtonMetrics.small() {
    return const .new(buttonSize: 32, iconSize: 16);
  }

  factory GlyphIconButtonMetrics.xsmall() {
    return const .new(buttonSize: 28, iconSize: 14);
  }

  GlyphIconButtonMetrics copyWith({double? buttonSize, double? iconSize}) {
    return .new(
      buttonSize: buttonSize ?? this.buttonSize,
      iconSize: iconSize ?? this.iconSize,
    );
  }
}
