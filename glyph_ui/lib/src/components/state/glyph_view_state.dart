import 'package:flutter/material.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_spacing.dart';
import '../../tokens/glyph_typography.dart';

/// A centered state view for empty, error, or informational screens.
///
/// Renders a vertically stacked layout:
/// 1. [header] — any widget (icon, illustration, etc.)
/// 2. [title] — displayed as [GlyphTextStyles.h3]
/// 3. [description] — displayed as [GlyphTextStyles.small] in secondary color
/// 4. [action] — optional widget (button, link, etc.) at the bottom
///
/// ```dart
/// GlyphViewState(
///   header: Icon(Icons.inbox_outlined, size: 32, color: GlyphColors.textTertiary),
///   title: 'No events yet',
///   description: 'Events for this community will appear here.',
///   action: GlyphButton(label: 'Create Event', onPressed: () {}),
/// )
/// ```
class GlyphViewState extends StatelessWidget {
  const GlyphViewState({
    super.key,
    this.header,
    required this.title,
    required this.description,
    this.action,
  });

  final Widget? header;
  final String title;
  final String description;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (header != null) ...[
            header!,
            const SizedBox(height: GlyphSpacing.s3),
          ],
          Text(title, style: GlyphTextStyles.h3),
          const SizedBox(height: 4),
          Text(
            description,
            style: GlyphTextStyles.small.copyWith(
              color: GlyphColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          if (action != null) ...[
            const SizedBox(height: GlyphSpacing.s4),
            action!,
          ],
        ],
      ),
    );
  }
}
