import 'package:flutter/material.dart';

/// Raw color constants extracted from the Glyph design system.
/// Maps directly to the CSS custom properties in the reference UI.
abstract final class GlyphColors {
  // Background: #f5f7fa (slate-50)
  static const Color background = Color(0xFFF5F7FA);

  // Surface: #ffffff (slate-0)
  static const Color surface = Color(0xFFFFFFFF);

  // Surface subtle: #f5f7fa (slate-50)
  static const Color surfaceSubtle = background;

  // Surface strong: #f2f5f8 (slate-100)
  static const Color surfaceStrong = Color(0xFFF2F5F8);

  // Surface disabled: #f2f5f8 (slate-100)
  static const Color surfaceDisabled = Color(0xFFF2F5F8);

  // Content (primary): #181b25 (slate-900)
  static const Color content = Color(0xFF181B25);

  // Content subtle: #525866 (slate-600)
  static const Color contentSubtle = Color(0xFF525866);

  // Content disabled: #99a0ae (slate-400)
  static const Color contentDisabled = Color(0xFF99A0AE);

  // Border: #e1e4ea (slate-200)
  static const Color border = Color(0xFFE1E4EA);

  // Border strong: #cacfd8 (slate-300)
  static const Color borderStrong = Color(0xFFCACFD8);

  // Border disabled: slate-alpha-16 (16% of #99a0ae)
  static const Color borderDisabled = Color(0x2999A0AE);

  // Accent primary: #693ee0 (purple-600)
  static const Color accentPrimary = Color(0xFF693EE0);

  // Accent subtle/container: #efebff (purple-50)
  static const Color accentSubtleContainer = Color(0xFFEFEBFF);

  // Feedback error: error-base (red-500/600 family), container error-lighter
  static const Color feedbackError = Color(0xFFEF4444);
  static const Color feedbackErrorContainer = Color(0xFFFEE2E2);

  // Feedback success: success-base (green-500/600 family), container success-lighter
  static const Color feedbackSuccess = Color(0xFF10B981);
  static const Color feedbackSuccessContainer = Color(0xFFD1FAE5);

  // Feedback attention: away-base (yellow-500/600 family), container away-lighter
  static const Color feedbackAttention = Color(0xFFF59E0B);
  static const Color feedbackAttentionContainer = Color(0xFFFEF3C7);

}

/// ThemeExtension that carries Glyph's semantic colors through the widget tree.
/// Access via: `Theme.of(context).extension<GlyphColorTokens>()!`
@immutable
class GlyphColorTokens extends ThemeExtension<GlyphColorTokens> {
  const GlyphColorTokens({
    required this.background,
    required this.surface,
    required this.surfaceSubtle,
    required this.surfaceStrong,
    required this.surfaceDisabled,
    required this.content,
    required this.contentSubtle,
    required this.contentDisabled,
    required this.border,
    required this.borderStrong,
    required this.borderDisabled,
    required this.accentPrimary,
    required this.accentSubtleContainer,
    required this.feedbackError,
    required this.feedbackErrorContainer,
    required this.feedbackSuccess,
    required this.feedbackSuccessContainer,
    required this.feedbackAttention,
    required this.feedbackAttentionContainer,
  });

  factory GlyphColorTokens.light() => const GlyphColorTokens(
    background: GlyphColors.background,
    surface: GlyphColors.surface,
    surfaceSubtle: GlyphColors.surfaceSubtle,
    surfaceStrong: GlyphColors.surfaceStrong,
    surfaceDisabled: GlyphColors.surfaceDisabled,
    content: GlyphColors.content,
    contentSubtle: GlyphColors.contentSubtle,
    contentDisabled: GlyphColors.contentDisabled,
    border: GlyphColors.border,
    borderStrong: GlyphColors.borderStrong,
    borderDisabled: GlyphColors.borderDisabled,
    accentPrimary: GlyphColors.accentPrimary,
    accentSubtleContainer: GlyphColors.accentSubtleContainer,
    feedbackError: GlyphColors.feedbackError,
    feedbackErrorContainer: GlyphColors.feedbackErrorContainer,
    feedbackSuccess: GlyphColors.feedbackSuccess,
    feedbackSuccessContainer: GlyphColors.feedbackSuccessContainer,
    feedbackAttention: GlyphColors.feedbackAttention,
    feedbackAttentionContainer: GlyphColors.feedbackAttentionContainer,
  );

  final Color background;
  final Color surface;
  final Color surfaceSubtle;
  final Color surfaceStrong;
  final Color surfaceDisabled;
  final Color content;
  final Color contentSubtle;
  final Color contentDisabled;
  final Color border;
  final Color borderStrong;
  final Color borderDisabled;
  final Color accentPrimary;
  final Color accentSubtleContainer;
  final Color feedbackError;
  final Color feedbackErrorContainer;
  final Color feedbackSuccess;
  final Color feedbackSuccessContainer;
  final Color feedbackAttention;
  final Color feedbackAttentionContainer;

  @override
  GlyphColorTokens copyWith({
    Color? background,
    Color? surface,
    Color? surfaceSubtle,
    Color? surfaceStrong,
    Color? surfaceDisabled,
    Color? content,
    Color? contentSubtle,
    Color? contentDisabled,
    Color? border,
    Color? borderStrong,
    Color? borderDisabled,
    Color? accentPrimary,
    Color? accentSubtleContainer,
    Color? feedbackError,
    Color? feedbackErrorContainer,
    Color? feedbackSuccess,
    Color? feedbackSuccessContainer,
    Color? feedbackAttention,
    Color? feedbackAttentionContainer,
  }) {
    return GlyphColorTokens(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceSubtle: surfaceSubtle ?? this.surfaceSubtle,
      surfaceStrong: surfaceStrong ?? this.surfaceStrong,
      surfaceDisabled: surfaceDisabled ?? this.surfaceDisabled,
      content: content ?? this.content,
      contentSubtle: contentSubtle ?? this.contentSubtle,
      contentDisabled: contentDisabled ?? this.contentDisabled,
      border: border ?? this.border,
      borderStrong: borderStrong ?? this.borderStrong,
      borderDisabled: borderDisabled ?? this.borderDisabled,
      accentPrimary: accentPrimary ?? this.accentPrimary,
      accentSubtleContainer:
          accentSubtleContainer ?? this.accentSubtleContainer,
      feedbackError: feedbackError ?? this.feedbackError,
      feedbackErrorContainer:
          feedbackErrorContainer ?? this.feedbackErrorContainer,
      feedbackSuccess: feedbackSuccess ?? this.feedbackSuccess,
      feedbackSuccessContainer:
          feedbackSuccessContainer ?? this.feedbackSuccessContainer,
      feedbackAttention: feedbackAttention ?? this.feedbackAttention,
      feedbackAttentionContainer:
          feedbackAttentionContainer ?? this.feedbackAttentionContainer,
    );
  }

  @override
  GlyphColorTokens lerp(GlyphColorTokens? other, double t) {
    if (other == null) return this;
    return GlyphColorTokens(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceSubtle: Color.lerp(surfaceSubtle, other.surfaceSubtle, t)!,
      surfaceStrong: Color.lerp(surfaceStrong, other.surfaceStrong, t)!,
      surfaceDisabled: Color.lerp(surfaceDisabled, other.surfaceDisabled, t)!,
      content: Color.lerp(content, other.content, t)!,
      contentSubtle: Color.lerp(contentSubtle, other.contentSubtle, t)!,
      contentDisabled: Color.lerp(contentDisabled, other.contentDisabled, t)!,
      border: Color.lerp(border, other.border, t)!,
      borderStrong: Color.lerp(borderStrong, other.borderStrong, t)!,
      borderDisabled: Color.lerp(borderDisabled, other.borderDisabled, t)!,
      accentPrimary: Color.lerp(accentPrimary, other.accentPrimary, t)!,
      accentSubtleContainer:
          Color.lerp(accentSubtleContainer, other.accentSubtleContainer, t)!,
      feedbackError: Color.lerp(feedbackError, other.feedbackError, t)!,
      feedbackErrorContainer:
          Color.lerp(feedbackErrorContainer, other.feedbackErrorContainer, t)!,
      feedbackSuccess: Color.lerp(feedbackSuccess, other.feedbackSuccess, t)!,
      feedbackSuccessContainer: Color.lerp(
          feedbackSuccessContainer, other.feedbackSuccessContainer, t)!,
      feedbackAttention: Color.lerp(
          feedbackAttention, other.feedbackAttention, t)!,
      feedbackAttentionContainer: Color.lerp(
          feedbackAttentionContainer, other.feedbackAttentionContainer, t)!,
    );
  }
}
