import 'package:flutter/material.dart';
import 'package:imposto/constants/theme_colors.dart';

enum ThemedTextVariant {
  primary,
  secondary,
  muted,

  danger,
  mystery,
  success,
  warning,
  info,

  lobby,
  voting,
  discussion,
  impostor,
}

class ThemedText extends StatelessWidget {
  final String content;

  final FontWeight? fontWeight;
  final double? fontSize;

  final int? maxLines;
  final TextOverflow? overflow;

  final TextAlign? textAlign;

  final bool glow;
  final bool uppercase;

  final double? letterSpacing;
  final double? height;
  final String? fontFamily;
  final ThemedTextVariant variant;

  const ThemedText({
    super.key,
    required this.content,

    this.fontWeight,
    this.fontSize,

    this.maxLines,
    this.overflow,

    this.textAlign,

    this.glow = false,
    this.uppercase = false,

    this.letterSpacing,
    this.height,
    this.fontFamily,
    this.variant = ThemedTextVariant.primary,
  });

  Color _resolveColor() {
    switch (variant) {
      case ThemedTextVariant.primary:
        return ThemeColors.textPrimary;

      case ThemedTextVariant.secondary:
        return ThemeColors.textSecondary;

      case ThemedTextVariant.muted:
        return ThemeColors.textMuted;

      case ThemedTextVariant.danger:
        return ThemeColors.danger500;

      case ThemedTextVariant.mystery:
        return ThemeColors.mystery500;

      case ThemedTextVariant.success:
        return ThemeColors.success500;

      case ThemedTextVariant.warning:
        return ThemeColors.warning500;

      case ThemedTextVariant.info:
        return ThemeColors.info500;

      case ThemedTextVariant.lobby:
        return ThemeColors.lobby;

      case ThemedTextVariant.voting:
        return ThemeColors.voting;

      case ThemedTextVariant.discussion:
        return ThemeColors.discussion;

      case ThemedTextVariant.impostor:
        return ThemeColors.impostorReveal;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _resolveColor();

    return Text(
      uppercase ? content.toUpperCase() : content,
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
      
      style: TextStyle(
        color: color,

        fontWeight: fontWeight ?? FontWeight.w600,
        fontSize: fontSize ?? 15,
        fontFamily: fontFamily,
        letterSpacing: letterSpacing ?? 0.3,
        height: height ?? 1.2,
        shadows: glow
            ? [Shadow(color: color.withOpacity(0.7), blurRadius: 7)]
            : null,
      ),
    );
  }
}
