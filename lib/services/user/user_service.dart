import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roomies_app/models/user_model.dart';
import 'package:roomies_app/services/firestore/firestore_service.dart';
import 'package:roomies_app/services/secure_sotrage/secure_storage_service.dart';
import 'package:roomies_app/utils/firestore_keys.dart';
import 'package:roomies_app/utils/secure_storage_keys.dart';

class UserService {
  Future<UserModel?> getUser() async {
    try {
      String? uid = await SecureStorageService().read(SecureStorageKeys.uid);
      if (uid == null) {
        Exception('No UID found in secure storage');
        return null;
      }
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
