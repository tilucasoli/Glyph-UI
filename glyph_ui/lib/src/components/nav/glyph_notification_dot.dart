import 'package:flutter/material.dart';

import '../../tokens/glyph_colors.dart';

/// 8×8 red dot indicating unread notifications.
///
/// Matches `.notification-dot` from the design reference:
/// - 8×8px circle
/// - Background: --accent-danger (#ff4b4b)
/// - Border: 2px solid --bg-surface (white) for contrast
///
/// Typically placed as an overlay inside a [Stack]:
/// ```dart
/// Stack(
///   children: [
///     Icon(Icons.notifications_outlined),
///     Positioned(
///       top: 0,
///       right: 0,
///       child: GlyphNotificationDot(),
///     ),
///   ],
/// )
/// ```
class GlyphNotificationDot extends StatelessWidget {
  const GlyphNotificationDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: GlyphColors.accentDanger,
        shape: BoxShape.circle,
        border: Border.all(
          color: GlyphColors.bgSurface,
          width: 2,
        ),
      ),
    );
  }
}
