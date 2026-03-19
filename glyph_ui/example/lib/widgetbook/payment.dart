import 'package:flutter/material.dart';
import 'package:glyph_ui/glyph_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Payment Method Cards', type: GlyphPaymentMethodCard, path: '[Glyph]/Payment')
Widget paymentMethodCards(BuildContext context) {
  return Row(
    children: [
      Expanded(
        child: GlyphPaymentMethodCard(
          label: 'Credit Card',
          icon: const Icon(Icons.credit_card),
          isSelected: true,
          onTap: () {},
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: GlyphPaymentMethodCard(
          label: 'PayPal',
          icon: const Icon(Icons.account_balance_wallet_outlined),
          isSelected: false,
          onTap: () {},
        ),
      ),
    ],
  );
}

@widgetbook.UseCase(name: 'Secure Badge', type: GlyphSecureBadge, path: '[Glyph]/Payment')
Widget secureBadge(BuildContext context) {
  return const GlyphSecureBadge();
}
