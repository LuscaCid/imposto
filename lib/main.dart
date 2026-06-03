import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imposto/constants/theme_colors.dart';
import 'package:imposto/layout/app_tab_page.dart';
import 'package:imposto/screens/create_match.dart';
import 'package:imposto/screens/lobby.dart';
import 'package:imposto/screens/signin.dart';
import 'package:imposto/screens/splash_screen.dart';
import 'package:imposto/services/auth_service.dart';
import 'package:imposto/services/matches_provider.dart';
import 'package:imposto/services/rooms_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authService = AuthService();
  final matchProvider = MatchProvider();
  final roomProvider = RoomsProvider();
  await authService.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>.value(value: authService),
        ChangeNotifierProvider<MatchProvider>.value(value: matchProvider),
        ChangeNotifierProvider<RoomsProvider>.value(value: roomProvider)
      ],
      child: const ImpostorApp(),
    ),
  );
}

class ImpostorApp extends StatelessWidget {
  const ImpostorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Impostor',
      themeMode: ThemeMode.dark,
      home: const SplashScreen(),
      routes: {
        '/signin': (_) => const SignInPage(pageTitle: 'Entrar'),
        '/home': (_) => const AppTabPage(),
        '/lobby': (_) => const LobbyPage()
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,

        brightness: Brightness.dark,

        scaffoldBackgroundColor: ThemeColors.background,

        primaryColor: ThemeColors.primary600,

        splashColor: ThemeColors.primary400.withOpacity(0.12),

        highlightColor: Colors.transparent,

        dividerColor: ThemeColors.border,

        fontFamily: "Inter",

        colorScheme: ColorScheme.dark(
          primary: ThemeColors.primary600,
          secondary: ThemeColors.mystery500,

          surface: ThemeColors.surface,
          error: ThemeColors.danger500,

          onPrimary: ThemeColors.textPrimary,
          onSecondary: ThemeColors.textPrimary,
          onSurface: ThemeColors.textPrimary,
          onError: ThemeColors.textPrimary,
        ),

        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: false,

          backgroundColor: ThemeColors.surface,

          foregroundColor: ThemeColors.textPrimary,

          surfaceTintColor: Colors.transparent,

          titleTextStyle: TextStyle(
            color: ThemeColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),

          iconTheme: IconThemeData(color: ThemeColors.textPrimary),
        ),

        tabBarTheme: TabBarThemeData(
          labelColor: ThemeColors.textPrimary,

          unselectedLabelColor: ThemeColors.textMuted,

          indicatorSize: TabBarIndicatorSize.tab,

          labelStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),

        cardTheme: CardThemeData(
          elevation: 0,

          color: ThemeColors.surfaceAlt,

          shadowColor: Colors.black.withOpacity(0.4),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
            side: BorderSide(color: ThemeColors.border),
          ),
        ),

        iconTheme: IconThemeData(color: ThemeColors.primary400),

        floatingActionButtonTheme: FloatingActionButtonThemeData(
          elevation: 0,

          backgroundColor: ThemeColors.primary600,

          foregroundColor: ThemeColors.textPrimary,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,

            backgroundColor: ThemeColors.primary600,

            foregroundColor: ThemeColors.textPrimary,

            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),

            textStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
        ),

        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: ThemeColors.textPrimary,

            side: BorderSide(color: ThemeColors.border),

            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,

          fillColor: ThemeColors.surfaceAlt,

          hintStyle: TextStyle(color: ThemeColors.textMuted),

          labelStyle: TextStyle(color: ThemeColors.textSecondary),

          prefixIconColor: ThemeColors.primary400,

          suffixIconColor: ThemeColors.textMuted,

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 18,
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: ThemeColors.border),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: ThemeColors.border),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: ThemeColors.primary500, width: 1.6),
          ),

          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: ThemeColors.danger500),
          ),
        ),

        textTheme: TextTheme(
          headlineLarge: TextStyle(
            color: ThemeColors.textPrimary,
            fontWeight: FontWeight.w900,
          ),

          headlineMedium: TextStyle(
            color: ThemeColors.textPrimary,
            fontWeight: FontWeight.w800,
          ),

          titleLarge: TextStyle(
            color: ThemeColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),

          bodyLarge: TextStyle(color: ThemeColors.textSecondary),

          bodyMedium: TextStyle(color: ThemeColors.textSecondary),

          labelLarge: TextStyle(
            color: ThemeColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),

        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,

          backgroundColor: ThemeColors.surfaceAlt,

          contentTextStyle: TextStyle(color: ThemeColors.textPrimary),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),

        dialogTheme: DialogThemeData(
          backgroundColor: ThemeColors.surface,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),

        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: ThemeColors.surface,

          modalBackgroundColor: ThemeColors.surface,

          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
        ),
      ),
    );
  }
}
