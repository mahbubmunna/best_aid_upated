import 'package:bestaid/src/models/discussion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseHelper {
  static createChatRoom(Problem problem) {
    Map<String, dynamic> data = {
      'user_id': problem.userId,
      'message': problem.message,
      'reply_by': problem.replyBy,
    };
    Firestore.instance
        .collection('problem')
        .document(problem.id.toString())
        .setData(data)
        .catchError((e) {
      print(e);
    });
  }

  static Future<void> addMessage(Problem problem, String message, String role) {
    Map<String, dynamic> data = {
      'user_id': problem.userId,
      'message': problem.message,
      'reply_by': problem.replyBy,
    };
    Firestore.instance
        .collection('problem')
        .document(problem.id.toString())
        .updateData(data)
        .catchError((e) {
      print(e.toString());
    });
    DateTime now = DateTime.now();

    Map<String, dynamic> chatMessage = {
      'message': message,
      'role': role,
      'time': now.toIso8601String(),
    };
    Firestore.instance
        .collection('problem')
        .document(problem.id.toString())
        .collection('discussion')
        .add(chatMessage)
        .catchError((e) {
      print(e.toString());
    });
  }

  static getChats(Problem problem) async {
    return Firestore.instance
        .collection('problem')
        .document(problem.id.toString())
        .collection('discussion')
        .orderBy('time')
        .snapshots();
  }
}
