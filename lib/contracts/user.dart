class User {
  final String username;
  final String uuid;
  final int icon;

  const User({
    required this.username,
    required this.icon,
    required this.uuid
  });

  factory User.fromJson(Map<String, dynamic> json) =>
    User(
      uuid: json['uuid'],
      username: json['username'],
      icon: json['icon'],
    );

  Map<String, dynamic> toJson() => {
    'uuid': uuid,
    'username': username,
    'icon': icon
  };
}