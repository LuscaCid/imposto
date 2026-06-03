import 'package:imposto/contracts/match.dart';

final List<Match> mockedMatches = [
  Match(
    answerDuration: 50,
    votingDuration: 60,
    uuid: '1',
    code: 'SPY847',
    name: 'Sala Sombria',
    hostPlayerId: 'host_1',

    status: MatchStatus.waiting,
    phase: MatchPhase.lobby,

    maxPlayers: 10,
    minPlayers: 4,

    currentRound: 0,
    totalRounds: 5,

    impostorCount: 1,

    isLocked: false,
    ranked: false,

    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),

  Match(
    answerDuration: 50,
    votingDuration: 60,
    uuid: '2',
    code: 'DARK22',

    name: 'Investigação Mortal',
    hostPlayerId: 'host_2',

    status: MatchStatus.starting,
    phase: MatchPhase.reveal,

    maxPlayers: 8,
    minPlayers: 4,

    currentRound: 1,
    totalRounds: 6,

    impostorCount: 2,

    isLocked: true,
    ranked: true,

    startedAt: DateTime.now(),

    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),

  Match(
    answerDuration: 50,
    votingDuration: 60,
    uuid: '3',
    code: 'VOID77',

    name: 'Entre Traidores',
    hostPlayerId: 'host_3',

    status: MatchStatus.playing,
    phase: MatchPhase.discussion,

    maxPlayers: 12,
    minPlayers: 5,

    currentRound: 3,
    totalRounds: 8,

    impostorCount: 2,

    isLocked: true,
    ranked: true,

    startedAt: DateTime.now(),

    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),

  Match(
    answerDuration: 50,
    votingDuration: 60,
    uuid: '4',
    code: 'VOTE99',

    name: 'Última Votação',
    hostPlayerId: 'host_4',

    status: MatchStatus.voting,
    phase: MatchPhase.voting,

    maxPlayers: 9,
    minPlayers: 4,

    currentRound: 4,
    totalRounds: 5,

    impostorCount: 1,

    isLocked: true,
    ranked: false,

    startedAt: DateTime.now(),

    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),

  Match(
    answerDuration: 50,
    votingDuration: 60,
    uuid: '5',
    code: 'FINALX',

    name: 'O Impostor Venceu',
    hostPlayerId: 'host_5',

    status: MatchStatus.finished,
    phase: MatchPhase.result,

    maxPlayers: 10,
    minPlayers: 5,

    currentRound: 5,
    totalRounds: 5,

    impostorCount: 2,

    isLocked: true,
    ranked: true,

    startedAt: DateTime.now().subtract(const Duration(minutes: 25)),

    finishedAt: DateTime.now(),

    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
];

class MatchMock {
  static final matches = mockedMatches;
}
