import 'package:firebase_auth/firebase_auth.dart';
import 'package:roomies_app/services/secure_storage/secure_storage_service.dart';
import 'package:roomies_app/utils/secure_storage_keys.dart';

class AuthService {
  loginWithEmail(String email, String password) async {
    try {
      final UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      await SecureStorageService()
          .write(SecureStorageKeys.uid, credential.user!.uid);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      return e;
    }
  }
}
