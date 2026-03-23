import 'package:flutter/widgets.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_radius.dart';
import '../../utils/widget_size_property.dart';

/// Preset sizes for [GlyphCard] content padding.
enum GlyphCardSize {
  small,
  medium,
  large,
}

/// Visual and layout properties for [GlyphCard].
///
/// Non-interactive wrapper: colors and radii are plain values. Layout uses
/// [WidgetCustomProperty] keyed by [GlyphCardSize].
@immutable
final class GlyphCardStyle {
  GlyphCardStyle({
    required this.backgroundColor,
    required this.borderSide,
    required this.borderRadius,
    required this.padding,
    this.shadows = const [],
  });

  static final WidgetCustomProperty<EdgeInsets, GlyphCardSize> _defaultPadding =
      WidgetCustomProperty.resolveWith(
    (size) => switch (size) {
      .small => const EdgeInsets.all(16),
      .medium => const EdgeInsets.all(24),
      .large => const EdgeInsets.all(32),
    },
  );

  final Color backgroundColor;
  final BorderSide borderSide;
  final BorderRadius borderRadius;
  final List<BoxShadow> shadows;

  final WidgetCustomProperty<EdgeInsets, GlyphCardSize> padding;

  factory GlyphCardStyle.surface() {
    return .new(
      backgroundColor: GlyphColors.surface,
      borderSide: BorderSide(color: GlyphColors.border),
      borderRadius: GlyphRadius.borderLarge,
      padding: _defaultPadding,
      shadows: [
        BoxShadow(
          color: GlyphColors.content.withValues(alpha: 0.02),
          blurRadius: 8,
          offset: const .new(0, 2),
        ),
      ],
    );
  }

  GlyphCardStyle copyWith({
    Color? backgroundColor,
    BorderSide? borderSide,
    BorderRadius? borderRadius,
    List<BoxShadow>? shadows,
    WidgetCustomProperty<EdgeInsets, GlyphCardSize>? padding,
  }) {
    return .new(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderSide: borderSide ?? this.borderSide,
      borderRadius: borderRadius ?? this.borderRadius,
      shadows: shadows ?? this.shadows,
      padding: padding ?? this.padding,
    );
  }
}
