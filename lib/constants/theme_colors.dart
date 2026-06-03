// Dark sinister palette for impostor/social deduction games
// Inspired by Tailwind palettes: zinc + red + violet + rose

import 'package:flutter/material.dart';

class ThemeColors {
  ThemeColors._();

  // =========================
  // BASE / BACKGROUND
  // =========================

  static const Color background = Color(0xFF09090B); // zinc-950
  static const Color surface = Color(0xFF18181B); // zinc-900
  static const Color surfaceAlt = Color(0xFF27272A); // zinc-800
  static const Color border = Color(0xFF3F3F46); // zinc-700

  // =========================
  // TEXT
  // =========================

  static const Color textPrimary = Color(0xFFFAFAFA); // zinc-50
  static const Color textSecondary = Color(0xFFD4D4D8); // zinc-300
  static const Color textMuted = Color(0xFF71717B); // zinc-500

  static const Color zinc50 = Color(0xFFFAFAFA); // zinc-50
  static const Color zinc100 = Color(0xFFF4F4F5); // zinc-100
  static const Color zinc200 = Color(0xFFE4E4E7); // zinc-200
  static const Color zinc300 = Color(0xFFD4D4D8); // zinc-300
  static const Color zinc400 = Color(0xFFA1A1AA); // zinc-400
  static const Color zinc500 = Color(0xFF71717A); // zinc-500
  static const Color zinc600 = Color(0xFF52525B); // zinc-600
  static const Color zinc700 = Color(0xFF3F3F46); // zinc-700
  static const Color zinc800 = Color(0xFF27272A); // zinc-800
  static const Color zinc900 = Color(0xFF18181B); // zinc-900

  // Blue (Tailwind Blue)
  static const Color blue50 = Color(0xFFEFF6FF); // blue-50
  static const Color blue100 = Color(0xFFDBEAFE); // blue-100
  static const Color blue200 = Color(0xFFBFDBFE); // blue-200
  static const Color blue300 = Color(0xFF93C5FD); // blue-300
  static const Color blue400 = Color(0xFF60A5FA); // blue-400
  static const Color blue500 = Color(0xFF3B82F6); // blue-500
  static const Color blue600 = Color(0xFF2563EB); // blue-600
  static const Color blue700 = Color(0xFF1D4ED8); // blue-700
  static const Color blue800 = Color(0xFF1E40AF); // blue-800
  static const Color blue900 = Color(0xFF1E3A8A); // blue-900

  // =========================
  // PRIMARY (violet/purple)
  // =========================

  static const Color primary50 = Color(0xFFF5F3FF); // violet-50
  static const Color primary100 = Color(0xFFEDE9FE); // violet-100
  static const Color primary200 = Color(0xFFDDD6FE); // violet-200
  static const Color primary300 = Color(0xFFC4B5FD); // violet-300
  static const Color primary400 = Color(0xFFA78BFA); // violet-400
  static const Color primary500 = Color(0xFF8B5CF6); // violet-500
  static const Color primary600 = Color(0xFF7C3AED); // violet-600
  static const Color primary700 = Color(0xFF6D28D9); // violet-700
  static const Color primary800 = Color(0xFF5B21B6); // violet-800
  static const Color primary900 = Color(0xFF4C1D95); // violet-900

  // =========================
  // DANGER / IMPOSTOR
  // =========================

  static const Color danger50 = Color(0xFFFEF2F2); // red-50
  static const Color danger100 = Color(0xFFFEE2E2); // red-100
  static const Color danger200 = Color(0xFFFECACA); // red-200
  static const Color danger300 = Color(0xFFFCA5A5); // red-300
  static const Color danger400 = Color(0xFFF87171); // red-400
  static const Color danger500 = Color(0xFFEF4444); // red-500
  static const Color danger600 = Color(0xFFDC2626); // red-600
  static const Color danger700 = Color(0xFFB91C1C); // red-700
  static const Color danger800 = Color(0xFF991B1B); // red-800
  static const Color danger900 = Color(0xFF7F1D1D); // red-900

  // =========================
  // ACCENT / MYSTERY
  // =========================

  static const Color mystery50 = Color(0xFFFDF4FF); // fuchsia-50
  static const Color mystery100 = Color(0xFFFAE8FF); // fuchsia-100
  static const Color mystery200 = Color(0xFFF5D0FE); // fuchsia-200
  static const Color mystery300 = Color(0xFFF0ABFC); // fuchsia-300
  static const Color mystery400 = Color(0xFFE879F9); // fuchsia-400
  static const Color mystery500 = Color(0xFFD946EF); // fuchsia-500
  static const Color mystery600 = Color(0xFFC026D3); // fuchsia-600
  static const Color mystery700 = Color(0xFFA21CAF); // fuchsia-700
  static const Color mystery800 = Color(0xFF86198F); // fuchsia-800
  static const Color mystery900 = Color(0xFF701A75); // fuchsia-900

  // =========================
  // SUCCESS
  // =========================

  static const Color success500 = Color(0xFF22C55E); // green-500
  static const Color success600 = Color(0xFF16A34A); // green-600

  // =========================
  // WARNING
  // =========================

  static const Color warning500 = Color(0xFFF59E0B); // amber-500
  static const Color warning600 = Color(0xFFD97706); // amber-600

  // =========================
  // INFO
  // =========================

  static const Color info500 = Color(0xFF3B82F6); // blue-500
  static const Color info600 = Color(0xFF2563EB); // blue-600

  // =========================
  // GAME STATES
  // =========================

  // Lobby / waiting players
  static const Color lobby = primary600;

  // Voting screen
  static const Color voting = mystery600;

  // Impostor reveal
  static const Color impostorReveal = danger600;


  // Discussion phase
  static const Color discussion = primary500;

  // Match finished
  static const Color matchEnd = danger700;

  // =========================
  // MATERIAL SWATCH
  // =========================

  static const Map<int, Color> primarySwatch = {
    50: primary50,
    100: primary100,
    200: primary200,
    300: primary300,
    400: primary400,
    500: primary500,
    600: primary600,
    700: primary700,
    800: primary800,
    900: primary900,
  };

  static const MaterialColor material = MaterialColor(
    0xFF8B5CF6,
    primarySwatch,
  );
}