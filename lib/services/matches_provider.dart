import 'package:flutter/material.dart';
import 'package:imposto/contracts/api_get_response.dart';
import 'package:imposto/contracts/api_save_response.dart';
import 'package:imposto/contracts/room.dart';
import 'package:imposto/contracts/user.dart';
import 'package:imposto/mock/match.dart';
import 'package:imposto/services/api_service.dart';
import 'package:imposto/contracts/match.dart';

class MatchProvider extends ChangeNotifier {
  late Match? match;
  late List<User> matchPlayers;
  late Room room;

  Future<void> joinRoomMatch(Room joinedRoomMatch) async {
    // TODO: enviar evento de entrar na partida aos demais players
    room = joinedRoomMatch;
    match = joinedRoomMatch.match;
    matchPlayers = joinedRoomMatch.players;
    notifyListeners();
  }

  // TODO: talvez mudar para mensagem de socket futuramente
  Future<void> deleteMatch ({required String matchUUID}) async {
    await ApiService.fetch(
      url: "match/delete/$matchUUID", 
      method: Method.delete,
    );
  }

  Future<ApiSaveResponse<Match>> createMatch ({required Match payload}) async {
    return await ApiService.fetch<ApiSaveResponse<Match>>(
      method: Method.post,
      url: 'match/create',
      payload: payload.toJson(),
      fromJson: (json) => ApiSaveResponse.fromJson(
        json, 
        (json) => Match.fromJson(json)
      )
    );
  }

  // TODO: implementar a renderização do chat com as ultimas mensagens, campo e botaão de enviar
  // que vai ser usado em lobby, votação 
  // e na tela de resultados 
  void _renderChatBottomSheet () {

  }
}