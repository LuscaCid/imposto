import 'package:flutter/material.dart';
import 'package:imposto/constants/theme_colors.dart';
import 'package:imposto/services/auth_service.dart';
import 'package:provider/provider.dart';

class PageWrapper extends StatelessWidget {
  final Widget child;

  const PageWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<AuthService>(context).currentThemeMode;
    return Scaffold(
      backgroundColor: ThemeColors.background,
      resizeToAvoidBottomInset: true,
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.bottomCenter,
            radius: 1.4,
            colors: [
              ThemeColors.primary600.withOpacity(0.45),
              ThemeColors.primary600.withOpacity(0.25),
              ThemeColors.background,
            ],
            stops: [0.0, 0.4, .8],
          ),
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: child,
        ),
      ),
    );
  }
}
