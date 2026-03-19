import 'package:flutter/material.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_radius.dart';
import '../../tokens/glyph_spacing.dart';

/// Selectable payment method card.
///
/// Matches `.method-card` / `.method-card.active` from the design:
/// - Border: 1px solid --border-medium (#e5e5e5), radius-md (16px)
/// - Padding: --space-4 (16px)
/// - Active: border textPrimary + background #fafafa
/// - Animates between states in 200ms
///
/// Typically placed inside a [Row] alongside other [GlyphPaymentMethodCard]s
/// to form a payment method toggle.
///
/// ```dart
/// Row(
///   children: [
///     Expanded(
///       child: GlyphPaymentMethodCard(
///         label: 'Credit Card',
///         icon: Icon(Icons.credit_card),
///         isSelected: _method == PaymentMethod.card,
///         onTap: () => setState(() => _method = PaymentMethod.card),
///       ),
///     ),
///     const SizedBox(width: 12),
///     Expanded(
///       child: GlyphPaymentMethodCard(
///         label: 'PayPal',
///         icon: Icon(Icons.account_balance_wallet_outlined),
///         isSelected: _method == PaymentMethod.paypal,
///         onTap: () => setState(() => _method = PaymentMethod.paypal),
///       ),
///     ),
///   ],
/// )
/// ```
class GlyphPaymentMethodCard extends StatefulWidget {
  const GlyphPaymentMethodCard({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final Widget icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<GlyphPaymentMethodCard> createState() => _GlyphPaymentMethodCardState();
}

class _GlyphPaymentMethodCardState extends State<GlyphPaymentMethodCard> {
  bool _hovered = false;

  Color get _borderColor {
    if (widget.isSelected) return GlyphColors.textPrimary;
    if (_hovered) return GlyphColors.textPrimary;
    return GlyphColors.borderMedium;
  }

  Color get _bgColor =>
      widget.isSelected ? const Color(0xFFFAFAFA) : GlyphColors.bgSurface;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(GlyphSpacing.s4),
          decoration: BoxDecoration(
            color: _bgColor,
            border: Border.all(color: _borderColor),
            borderRadius: GlyphRadius.borderMd,
          ),
          child: Row(
            children: [
              IconTheme(
                data: const IconThemeData(
                  color: GlyphColors.textPrimary,
                  size: 20,
                ),
                child: widget.icon,
              ),
              const SizedBox(width: 12),
              Text(
                widget.label,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: GlyphColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
