import 'package:flutter/material.dart';
import 'package:imposto/screens/create_match.dart';
import 'package:imposto/screens/home.dart';
import 'package:imposto/services/auth_service.dart';
import 'package:provider/provider.dart';

import 'package:imposto/constants/theme_colors.dart';

class AppTabPage extends StatefulWidget {
  const AppTabPage({super.key});

  @override
  State<StatefulWidget> createState() => _AppTabPageState();
}

class _AppTabPageState extends State<AppTabPage>
    with SingleTickerProviderStateMixin {

  void _handleLogout(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    authService.signOut();

    Navigator.of(context).pushNamedAndRemoveUntil('/signin', (_) => false);
  }

  Widget userAvatar(String username, {bool isDark = true, double size = 42}) {
    final initial = username.isNotEmpty ? username[0].toUpperCase() : "?";

    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ThemeColors.primary600, ThemeColors.mystery600],
          tileMode: TileMode.clamp
        ),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: ThemeColors.border, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: ThemeColors.primary600.withOpacity(0.35),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: TextStyle(
          color: ThemeColors.textPrimary,
          fontWeight: FontWeight.w900,
          fontSize: size * 0.42,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    final username = authService.user != null ? authService.user!.username : "";

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: ThemeColors.background,

        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          backgroundColor: ThemeColors.surfaceAlt,

          title: Builder(
            builder: (around) => GestureDetector(
              onTap: () {
                final tabController = DefaultTabController.of(around);

                tabController.animateTo(2);
              },
              child: Row(
                children: [
                  userAvatar(username),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "AGENTE",
                          style: TextStyle(
                            color: ThemeColors.textMuted,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.5,
                          ),
                        ),

                        const SizedBox(height: 2),

                        Text(
                          username.isEmpty ? "Jogador" : username,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: ThemeColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 16),
              child: IconButton(
                icon: Icon(Icons.logout_rounded, color: ThemeColors.danger100),
                tooltip: 'Sair',
                onPressed: () => _handleLogout(context),
              ),
            ),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 4, left: 12, bottom: 4, right: 12),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: ThemeColors.surfaceAlt,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: ThemeColors.border),
              ),
              child: TabBar(
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,

                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: LinearGradient(
                    colors: [ThemeColors.primary600, ThemeColors.mystery600],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: ThemeColors.primary700.withOpacity(0.35),
                      blurRadius: 12,
                      spreadRadius: 1,
                    ),
                  ],
                ),

                labelColor: ThemeColors.textPrimary,
                unselectedLabelColor: ThemeColors.textMuted,

                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),

                tabs: const [
                  Tab(icon: Icon(Icons.home_rounded), text: "Home"),
                  Tab(icon: Icon(Icons.meeting_room), text: "Partida"),
                  Tab(icon: Icon(Icons.settings_rounded), text: "Config"),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [ThemeColors.background, ThemeColors.surface],
            ),
          ),
          child: const TabBarView(
            children: [
              HomePage(),
              CreateMatchPage(),
              HomePage(),
              // QrScannerPage(),
              // SettingsPage(),
            ],
          ),
        ),
      ),
    );
  }
}
