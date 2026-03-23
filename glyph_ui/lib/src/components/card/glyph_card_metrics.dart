import 'package:flutter/widgets.dart';

/// Dimensional metrics for [GlyphCard].
///
/// Holds the content padding for each size preset. Use factory constructors
/// for standard sizes.
@immutable
final class GlyphCardMetrics {
  const GlyphCardMetrics({required this.padding});

  final EdgeInsets padding;

  /// 16 px padding on all sides.
  factory GlyphCardMetrics.small() {
    return const .new(padding: .all(16));
  }

  /// 24 px padding on all sides.
  factory GlyphCardMetrics.medium() {
    return const .new(padding: .all(24));
  }

  /// 32 px padding on all sides.
  factory GlyphCardMetrics.large() {
    return const .new(padding: .all(32));
  }

  GlyphCardMetrics copyWith({EdgeInsets? padding}) {
    return .new(padding: padding ?? this.padding);
  }
}
