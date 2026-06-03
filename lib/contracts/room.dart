import 'package:imposto/contracts/message.dart';
import 'package:imposto/contracts/user.dart';
import 'package:imposto/contracts/match.dart';

class Room {
  final String roomId;
  final List<Message> messages;
  final List<User> players;
  final Match match;

  const Room({
    required this.roomId,
    required this.players,
    required this.messages,
    required this.match,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
    roomId: json['roomId'],
    match: Match.fromJson(json['match']),
    players:
        (json['players']).map((el) {
              return User.fromJson(el);
            })
            as List<User>,
    messages:
        json['messages'].map((msg) {
              return Message.fromJson(msg);
            })
            as List<Message>,
  );

  Map<String, dynamic> toJson() => {
    'roomId': roomId,
    'match': match,
    'players': players,
    'messages': messages,
  };
}
