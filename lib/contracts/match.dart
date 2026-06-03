enum MatchStatus { waiting, starting, playing, voting, finished }

enum MatchPhase { lobby, reveal, discussion, voting, result }

class Match {
  final String? uuid;
  final String? code;

  final String name;
  final String? hostPlayerId;

  final MatchStatus? status;
  final MatchPhase? phase;

  final int maxPlayers;
  final int? minPlayers;
  final int? playersCount;

  final int? currentRound;
  final int totalRounds;

  final int impostorCount;
  final int answerDuration;
  final int votingDuration;

  final bool? isLocked;
  // TODO: futuramente implementar sistema ranqueado e passar se é uma ranked ou nao
  final bool? ranked;

  final DateTime? startedAt;
  final DateTime? finishedAt;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Match({
    required this.name,
    required this.totalRounds,
    required this.impostorCount,
    required this.isLocked,
    required this.votingDuration,
    required this.answerDuration,
    this.uuid,
    this.code,
    this.hostPlayerId,
    this.status,
    this.phase,
    this.playersCount,
    required this.maxPlayers,
    this.minPlayers,
    this.currentRound,
    // TODO ACIMA
    this.ranked,
    this.createdAt,
    this.updatedAt,
    this.startedAt,
    this.finishedAt,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      uuid: json['uuid'],
      code: json['code'],
      name: json['name'],
      hostPlayerId: json['hostPlayerId'],
      playersCount: json['playersCount'],
      status: MatchStatus.values.firstWhere((e) => e.name == json['status']),
      answerDuration: json['answerDuration'],
      votingDuration: json['votingDuration'],
      phase: MatchPhase.values.firstWhere((e) => e.name == json['phase']),

      maxPlayers: json['maxPlayers'],
      minPlayers: json['minPlayers'],

      currentRound: json['currentRound'],
      totalRounds: json['totalRounds'],

      impostorCount: json['impostorCount'],

      isLocked: json['isLocked'],
      ranked: json['ranked'],

      startedAt: json['startedAt'] != null
          ? DateTime.parse(json['startedAt'])
          : null,

      finishedAt: json['finishedAt'] != null
          ? DateTime.parse(json['finishedAt'])
          : null,

      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'code': code,
      'answerDuration': answerDuration,
      'votingDuration': votingDuration,
      'hostPlayerId': hostPlayerId,
      'status': status?.name ?? "",
      'phase': phase?.name ?? "",
      'playersCount': playersCount,
      'maxPlayers': maxPlayers,
      'minPlayers': minPlayers,
      'currentRound': currentRound,
      'totalRounds': totalRounds,
      'impostorCount': impostorCount,
      'isLocked': isLocked,
      'ranked': ranked,
      'startedAt': startedAt?.toIso8601String(),
      'finishedAt': finishedAt?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String() ?? "",
      'updatedAt': updatedAt?.toIso8601String() ?? "",
    };
  }
}
