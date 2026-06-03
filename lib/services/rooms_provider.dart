import 'package:flutter/material.dart';
import 'package:imposto/contracts/api_get_response.dart';
import 'package:imposto/contracts/api_save_response.dart';
import 'package:imposto/contracts/message.dart';
import 'package:imposto/contracts/room.dart';
import 'package:imposto/contracts/user.dart';
import 'package:imposto/mock/room.dart';
import 'package:imposto/services/api_service.dart';

class RoomsProvider extends ChangeNotifier {
  List<Room> _rooms = mockRooms;
  List<Room> get rooms => _rooms;

  Future<void> deleteRoom({required String matchUUID}) async {
    await ApiService.fetch(
      url: "room/delete/$matchUUID",
      method: Method.delete,
    );
  }

  Future<void> createRoom({required Room payload}) async {
    final response = await ApiService.fetch<ApiSaveResponse<Room>>(
      method: Method.post,
      url: 'room/create',
      payload: payload as Map<String, dynamic>,
      fromJson: (json) =>
          ApiSaveResponse.fromJson(json, (json) => Room.fromJson(json)),
    );

    _rooms = [response.data, ..._rooms];
    notifyListeners();
  }

  Future<void> loadMoreRooms({String matchQuery = ''}) async {
    final response = await ApiService.fetch<ApiGetResponse<List<Room>>>(
      url: 'room/latest',
      method: Method.get,
      fromJson: (json) => ApiGetResponse<List<Room>>.fromJson(
        json,
        (dataJson) =>
            (dataJson as List).map((item) => Room.fromJson(item)).toList(),
      ),
    );
    _rooms = response.data;
    notifyListeners();
  }
}
