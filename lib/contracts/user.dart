class User {
  final String username;
  final String uuid;
  final int icon;

  // TODO ram socket service injected prop
  final bool? isReady;

  const User({
    required this.username,
    required this.icon,
    required this.uuid,
    this.isReady
  });

  factory User.fromJson(Map<String, dynamic> json) =>
    User(
      uuid: json['uuid'],
      username: json['username'],
      icon: json['icon'],
      isReady: json['isReady']
    );

  Map<String, dynamic> toJson() => {
    'uuid': uuid,
    'username': username,
    'icon': icon,
    'isReady': isReady
  };
}