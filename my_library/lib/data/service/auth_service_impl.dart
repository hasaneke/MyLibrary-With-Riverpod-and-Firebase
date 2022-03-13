import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthService {
  Future<User?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    return null;
  }

  Future<User?> signInWithGoogle() async {
    return null;
  }

  Future<User?> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    return null;
  }

  Future<void> sendEmailVertification({required User user}) async {}

  Future<User?> getCurrentUser() async {
    return null;
  }

  Future<bool> sendPasswordResetRequest({required String email}) async {
    return false;
  }
}
