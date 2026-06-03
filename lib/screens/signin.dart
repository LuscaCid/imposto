import 'package:flutter/material.dart';
import 'package:imposto/components/page_wrapper.dart';
import 'package:imposto/components/profile_icon.dart';
import 'package:imposto/components/themed_text.dart';
import 'package:imposto/constants/theme_colors.dart';
import 'package:imposto/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:imposto/shared/icons_list.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key, required this.pageTitle});

  final String pageTitle;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _usernameController = TextEditingController();
  final double _gap = 18.0;
  int? _selectedProfileIconId = null;
  bool _loading = false;




  Future<void> _handleSignIn(BuildContext context) async {
    _usernameController.text;
  }

  @override 
  void dispose () {
    _usernameController.dispose();
    super.dispose();
  }

  void _handleSelectIcon (int iconId) {
    setState(() {
      _selectedProfileIconId = iconId;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<AuthService>(context).currentThemeMode;

    return PageWrapper(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ThemedText(
              content: "Impostor",
              fontSize: 32,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
              glow: true,
            ),
            Wrap(
              runAlignment: WrapAlignment.end,
              runSpacing: 2,
              spacing: 4,
              children: iconsList.entries.map((entry) {
                return ProfileIcon(
                  iconId: entry.key, 
                  onTap: () => _handleSelectIcon(entry.key),
                  selected: _selectedProfileIconId == entry.key
                );
              }).toList(),
            ),
            Column(
              spacing: 6,
              children: [
                TextField(
                  keyboardType: TextInputType.text,
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: ThemeColors.surface),
                    hintStyle: TextStyle(color: ThemeColors.border),
                    hintText: "Nome de usuário",
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _loading ? null : () => _handleSignIn(context),
                    label: Text(_loading ? "Entrando..." : "Entrar"),
                    icon: _loading
                        ? SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Icon(Icons.login),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
