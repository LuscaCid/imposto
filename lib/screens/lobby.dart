import 'package:flutter/material.dart';
import 'package:imposto/components/themed_text.dart';
import 'package:imposto/constants/theme_colors.dart';
import 'package:imposto/layout/match_layout.dart';
import 'package:imposto/services/matches_provider.dart';
import 'package:provider/provider.dart';

class LobbyPage extends StatefulWidget {
  const LobbyPage({super.key});

  @override
  State<StatefulWidget> createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {
  Widget _renderSettingsSection({required String key, required String value}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 8,
      children: [
        Text(
          value,
          style: TextStyle(
            color: ThemeColors.primary500,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          key,
          style: TextStyle(
            color: ThemeColors.primary300,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final match = Provider.of<MatchProvider>(context).match;
    if (match == null) {

    }
    return MatchLayout(
      appBarTitle: "LOBBY",
      child: SingleChildScrollView(
        
        child: Column(
          children: [
            // match settings appear here
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [ThemeColors.primary900, ThemeColors.mystery700],
                  tileMode: TileMode.mirror
                ),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: ThemeColors.border, width: 1.2),
              ),
              child: Row(
                children: [
                  _renderSettingsSection(key: "Jogadores", value: "${match!.playersCount} / ${match.maxPlayers}"),
                  _renderSettingsSection(key: "Impostores", value: "${match!.impostorCount}"),
                  _renderSettingsSection(key: "Rounds", value: "${match!.totalRounds}"),
                  _renderSettingsSection(key: "Tempo da dica", value: "${match!.answerDuration}"),
                  _renderSettingsSection(key: "Tempo da votação", value: "${match!.votingDuration}")
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}
