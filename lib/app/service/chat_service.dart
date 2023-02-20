import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hallo_doctor_client/app/service/doctor_service.dart';
import 'package:hallo_doctor_client/app/service/user_service.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import '../models/doctor_model.dart';

class ChatService {
  Future<Doctor> getDoctorByUserId(String userId) async {
    try {
      var user = await UserService().getUserModel();
      var doctor = await DoctorService().getDoctorDetail(user!.doctorId!);
      return doctor;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  ///TODO need to make it more clean
  Future<types.Room?> getRoomById(String roomId) async {
    try {
      var roomRef = await FirebaseFirestore.instance
          .collection('Rooms')
          .doc(roomId)
          .get();
      var roomDataFirebase = roomRef.data();
      if (roomDataFirebase == null) return null;
      int createdAt =
          (roomDataFirebase['createdAt'] as Timestamp).toDate().millisecond;
      int updatedAt =
          (roomDataFirebase['updatedAt'] as Timestamp).toDate().millisecond;
      List<types.User> listUser = (roomDataFirebase['userIds'] as List<dynamic>)
          .map((e) => types.User(id: e))
          .toList();
      types.Room roomData = types.Room(
          id: roomId,
          type: types.RoomType.direct,
          users: listUser,
          createdAt: createdAt,
          updatedAt: updatedAt,
          name: roomDataFirebase['name'],
          imageUrl: roomDataFirebase['imageUrl']);

      return roomData;
    } catch (e) {
      return Future.error(e);
    }
  }
}
