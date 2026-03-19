import 'package:flutter/material.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_radius.dart';
import '../../tokens/glyph_typography.dart';

/// Quantity stepper control.
///
/// Matches `.stepper` from the design reference:
/// - Container: 1px border-light border, --radius-pill, 4px padding
/// - Buttons: 32×32px circles, transparent, hover: border-light bg
/// - Count: 15px, w600, textPrimary
/// - Minus button disabled (and styled tertiary) when value == 0
///
/// ```dart
/// GlyphStepper(
///   value: _quantity,
///   onIncrement: () => setState(() => _quantity++),
///   onDecrement: () => setState(() => _quantity--),
/// )
/// ```
class GlyphStepper extends StatelessWidget {
  const GlyphStepper({
    super.key,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
    this.min = 0,
    this.max,
  });

  final int value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final int min;
  final int? max;

  @override
  Widget build(BuildContext context) {
    final canDecrement = value > min;
    final canIncrement = max == null || value < max!;

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: GlyphColors.bgSurface,
        borderRadius: GlyphRadius.borderPill,
        border: Border.all(color: GlyphColors.borderLight),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StepperButton(
            label: '−',
            onPressed: canDecrement ? onDecrement : null,
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 20,
            child: Text(
              '$value',
              textAlign: TextAlign.center,
              style: GlyphTextStyles.small.copyWith(
                color: GlyphColors.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(width: 16),
          _StepperButton(
            label: '+',
            onPressed: canIncrement ? onIncrement : null,
          ),
        ],
      ),
    );
  }
}

class _StepperButton extends StatefulWidget {
  const _StepperButton({required this.label, this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  State<_StepperButton> createState() => _StepperButtonState();
}

class _StepperButtonState extends State<_StepperButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onPressed == null;
    final color = isDisabled ? GlyphColors.textTertiary : GlyphColors.textPrimary;

    return MouseRegion(
      onEnter: isDisabled ? null : (_) => setState(() => _hovered = true),
      onExit: isDisabled ? null : (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: _hovered && !isDisabled
                ? GlyphColors.borderLight
                : Colors.transparent,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            widget.label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: color,
              height: 1,
            ),
          ),
        ),
      ),
    );
  }
}
