import 'package:flutter/material.dart';
import 'package:imposto/components/profile_icon.dart';
import 'package:imposto/components/themed_text.dart';
import 'package:imposto/constants/theme_colors.dart';
import 'package:imposto/contracts/room.dart';
import 'package:imposto/contracts/user.dart';
import 'package:imposto/services/matches_provider.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:imposto/contracts/match.dart';

class HomeMatchCard extends StatelessWidget {
  final Room room;
  final List<User> players;

  const HomeMatchCard({
    super.key,
    required this.players,
    required this.room,
  });

  Future<void> _handleJoinMatch(BuildContext context, Room room) async {
    // emitir evento para conexao na partida para que os outros dispositivos saibam que este usuario entrou
    await Provider.of<MatchProvider>(
      context,
      listen: false,
    ).joinRoomMatch(room);
    Navigator.pushReplacementNamed(context, '/lobby');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16),
      ),
      color: ThemeColors.primary900,
      margin: const EdgeInsets.all(6.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        child: Column(
          spacing: 15,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ThemedText(
                  content: room.match.name,
                  variant: ThemedTextVariant.primary,
                  fontSize: 18,
                ),
                Row(
                  spacing: 2,
                  children: [
                    ThemedText(
                      content: "${room.match.currentRound} / ${room.match.totalRounds}",
                      variant: ThemedTextVariant.muted,
                      fontSize: 12,
                    ),
                    Icon(Icons.timelapse),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  spacing: 2,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                      color: ThemeColors.primary700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: EdgeInsetsGeometry.all(12),
                        child: Row(
                          children: [
                            ThemedText(
                              content: room.match.phase!.name,
                              variant: ThemedTextVariant.primary,
                              fontSize: 14,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(horizontal: 6),
                      child: Row(
                        spacing: 4,
                        children: [
                          ThemedText(
                            content:
                                "${room.players.length} / ${room.match.maxPlayers}",
                            variant: ThemedTextVariant.primary,
                            fontSize: 14,
                          ),
                          SizedBox(
                            width: 120,
                            height: 35,
                            child: Stack(
                              // this says that will only render the first 5 players in room
                              children: players
                                  .asMap()
                                  .entries
                                  .where((entry) => entry.key < 5)
                                  .map((entry) {
                                    final index = entry.key;
                                    final player = entry.value;
                                    return Positioned(
                                      left:
                                          index * 20, // controla a sobreposição
                                      child: ProfileIcon(
                                        iconId: player.icon,
                                        isSmall: true,
                                      ),
                                    );
                                  })
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                  ],
                ),

                ElevatedButton(
                  onPressed: room.players.length == room.match.maxPlayers
                      ? null
                      : () => _handleJoinMatch(context, room),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(48, 48),
                    disabledBackgroundColor: ThemeColors.primary500,
                  ),
                  child: Center(
                    child: Icon(
                      room.match.isLocked! ? Icons.lock : Icons.play_arrow,
                      size: 17,
                    ),
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
