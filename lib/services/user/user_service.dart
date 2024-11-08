import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roomies_app/models/user_model.dart';
import 'package:roomies_app/services/firestore/firestore_service.dart';
import 'package:roomies_app/utils/firestore_keys.dart';

class UserService {
  Future<UserModel?> getUser(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await FirestoreService().readDocument(FirestoreKeys.users, uid);
      if (userDoc.exists) {
        return UserModel.fromDocument(
            userDoc.data() as Map<String, dynamic>, userDoc.id);
      } else {
        Exception('User document does not exist');
        return null;
      }
    } catch (e) {
      Exception('Error getting user: $e');
      return null;
    }
  }
}
