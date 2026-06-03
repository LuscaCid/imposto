import 'package:flutter/material.dart';
import 'package:imposto/components/profile_icon.dart';
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
  Widget _renderSettingsSection({
    required String key,
    required String value,
    bool dontRenderborder = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      decoration: BoxDecoration(
        border: dontRenderborder
            ? null
            : Border(
                right: BorderSide(color: ThemeColors.surfaceAlt, width: 1),
              ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              color: ThemeColors.primary500,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            key,
            style: TextStyle(
              color: ThemeColors.primary300,
              fontSize: 11,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  // vai passar a partida para todos os jogadores para a tela de recebimento de palavra e 15 segundos depois
  // vai
  Future<void> _handleInitiateMatch() async {}

  @override
  Widget build(BuildContext context) {
    final room = Provider.of<MatchProvider>(context).room;
    final match = room.match;
    final playersReady = room.players
        .where((player) => player.isReady == true)
        .length;

    return MatchLayout(
      appBarTitle: "LOBBY",
      child: Container(
        padding: EdgeInsets.all(10),
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 1.9,
            colors: [
              ThemeColors.primary600.withOpacity(0.45),
              ThemeColors.primary600.withOpacity(0.25),
              ThemeColors.primary600.withOpacity(0.15),
              ThemeColors.zinc900.withOpacity(0.90),
            ],
            stops: [0.0, 0.2, 0.4, .8],
          ),
        ),
        child: Stack(
          children: [
            Column(
              spacing: 20,
              children: [
                // match settings appear here
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: ThemeColors.surface.withOpacity(.50),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: ThemeColors.surfaceAlt,
                      width: 1.2,
                    ),
                  ),
                  child: Row(
                    spacing: 4,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _renderSettingsSection(
                        key: "Jogadores",
                        value: "${room!.players.length} / ${match.maxPlayers}",
                      ),
                      _renderSettingsSection(
                        key: "Impostores",
                        value: "${match!.impostorCount}",
                      ),
                      _renderSettingsSection(
                        key: "Rounds",
                        value: "${match!.totalRounds}",
                      ),
                      _renderSettingsSection(
                        key: "Dica",
                        value: "${match!.answerDuration}s",
                      ),
                      _renderSettingsSection(
                        key: "Votação",
                        value: "${match!.votingDuration}s",
                        dontRenderborder: true,
                      ),
                    ],
                  ),
                ),
                Column(
                  spacing: 5,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ThemedText(
                            content: "Jogadores",
                            variant: ThemedTextVariant.lobby,
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                          ThemedText(
                            content:
                                "$playersReady / ${room.players.length} ${playersReady > 1 ? "PRONTOS" : "PRONTO"}",
                            variant: ThemedTextVariant.success,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      spacing: 5,
                      children: [
                        ...room.players.map((el) {
                          final currentlyPlayerIsReady =
                              el.isReady != null && el.isReady == true;
                          return Container(
                            padding: EdgeInsets.only(right: 12, left: 7),
                            decoration: BoxDecoration(
                              color: ThemeColors.surface.withOpacity(.50),
                              borderRadius: BorderRadius.circular(10),
                              border: BoxBorder.all(
                                color: ThemeColors.zinc800,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  spacing: 5,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ProfileIcon(iconId: el.icon, isSmall: true),
                                    ThemedText(
                                      content: el.username,
                                      fontSize: 15,
                                      variant: ThemedTextVariant.success,
                                    ),
                                    if (el.uuid == match.hostPlayerId)
                                      Badge(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 4,
                                          horizontal: 6,
                                        ),
                                        backgroundColor: ThemeColors.primary900,
                                        textColor: ThemeColors.zinc100,
                                        label: ThemedText(
                                          content: "Host",
                                          variant: ThemedTextVariant.primary,
                                          fontSize: 13,
                                        ),
                                        largeSize: 30,
                                        smallSize: 30,
                                      ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: ThemeColors.textMuted.withOpacity(
                                      0.20,
                                    ),
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                  child: Row(
                                    spacing: 3,
                                    children: [
                                      ThemedText(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        content: currentlyPlayerIsReady
                                            ? "Pronto"
                                            : "Entrou",
                                        variant: currentlyPlayerIsReady
                                            ? ThemedTextVariant.success
                                            : ThemedTextVariant.muted,
                                      ),
                                      Icon(
                                        currentlyPlayerIsReady
                                            ? Icons.check_circle
                                            : Icons.hourglass_bottom,
                                        color: currentlyPlayerIsReady
                                            ? ThemeColors.success500
                                            : ThemeColors.warning500,
                                            size: 13,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        if (room.players.length < match.maxPlayers)
                          Row(
                            spacing: 5,
                            children: [
                              CircularProgressIndicator(strokeWidth: 2),
                              ThemedText(
                                content: "Esperando por jogadores...",
                                variant: ThemedTextVariant.muted,
                                fontSize: 14,
                              ),
                            ],
                          ),
                        ElevatedButton(
                          onPressed: _handleInitiateMatch,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 6,
                            children: [
                              ThemedText(content: "Iniciar jogo", fontSize: 18),
                              Icon(Icons.play_arrow),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.25,
              minChildSize: 0.15,
              maxChildSize: 0.9,
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: ThemeColors.surface,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  child: ListView(
                    controller: scrollController,
                    children: [
                      SizedBox(height: 12),

                      Center(
                        child: SizedBox(
                          width: 40,
                          child: Divider(
                            thickness: 4,
                            radius: BorderRadius.all(Radius.circular(5)),
                          ),
                        ),
                      ),

                      Padding(padding: EdgeInsets.all(16), child: Text('Chat')),

                      Column(
                        spacing: 4,
                        children: room.messages.map((el) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: ThemeColors.zinc900,
                            ),
                            child: Row(
                              spacing: 7,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ProfileIcon(
                                  iconId: el.user.icon,
                                  isSmall: true,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 5,
                                  children: [
                                    ThemedText(
                                      content: el.user.username,
                                      variant: ThemedTextVariant.lobby,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    ThemedText(
                                      content: el.content,
                                      variant: ThemedTextVariant.primary,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
