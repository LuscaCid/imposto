import 'package:imposto/contracts/user.dart';

class Message {
  final String content;
  final User user;
  final DateTime sentAt;

  const Message({
    required this.content,
    required this.user,
    required this.sentAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    content: json['content'],
    user: User.fromJson(json['user']),
    sentAt: json['sentAt'],
  );

  Map<String, dynamic> toJson() => {
    'content': content,
    'user': user,
    'sentAt': sentAt,
  };
}
