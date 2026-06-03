import 'package:flutter/material.dart';
import 'package:imposto/components/themed_text.dart';
import 'package:imposto/constants/theme_colors.dart';

class MatchLayout extends StatefulWidget {
  final Widget child;
  final String appBarTitle;
  final bool? renderMatchSettings;
  final int? roundDuration;

  const MatchLayout({
    super.key,
    required this.child,
    required this.appBarTitle,
    this.renderMatchSettings,
    this.roundDuration,
  });

  @override
  State<StatefulWidget> createState() => _MatchLayoutState();
}

class _MatchLayoutState extends State<MatchLayout> {
  void _handleExitMatch(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/home');

    // TODO: emitir evento de quit match (sem cancelar partida...)
  }

  void _renderMatchStepTimeline () {

  }

  void _renderMatchSettingsBottomSheet(BuildContext context) {

  }

  void _renderConfirmMatchExit(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: ThemedText(
            content: "Deseja realmente sair da partida?",
            variant: ThemedTextVariant.danger,
          ),
          actions: [
            ElevatedButton(
              onPressed: () => _handleExitMatch(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeColors.surfaceAlt,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 4,
                children: [
                  ThemedText(
                    content: "Sair",
                    variant: ThemedTextVariant.danger,
                  ),
                  Icon(Icons.exit_to_app),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => _handleExitMatch(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeColors.surfaceAlt,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 4,
                children: [
                  ThemedText(
                    content: "Cancelar",
                    variant: ThemedTextVariant.muted,
                  ),
                  Icon(Icons.cancel),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.background,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: ThemeColors.background,
        title: Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: ThemeColors.zinc200),
                  tooltip: 'Sair',
                  onPressed: () => _renderConfirmMatchExit(context),
                ),
                ThemedText(
                  content: widget.appBarTitle, 
                  variant: ThemedTextVariant.voting,
                  textAlign: TextAlign.center,
                  fontSize: 28,
                ),
                if (widget.renderMatchSettings != null && widget.renderMatchSettings == true) 
                  IconButton(
                    onPressed: () => _renderMatchSettingsBottomSheet(context),
                    icon: Icon(Icons.settings),
                  )
              ],
            ),
        ),
      ),
      body: widget.child,
    );
  }
}
