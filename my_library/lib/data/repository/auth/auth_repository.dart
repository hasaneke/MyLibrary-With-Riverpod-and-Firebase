import 'package:authentication/network/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: unused_import
import 'package:my_library/core/models/user.dart';

class AuthRepository implements IAuthService {
  final AuthService authService;
  AuthRepository({
    required this.authService,
  });
  @override
  Future<User?> getCurrentUser() {
    return authService.getCurrentUser();
  }

  @override
  Future<void> sendEmailVertification({required User user}) async {
    await authService.sendEmailVertification(user: user);
  }

  @override
  Future<User?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    return authService.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<User?> signInWithGoogle() async {
    return authService.signInWithGoogle();
  }

  @override
  Future<User?> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    return authService.signUpWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<bool> sendPasswordResetRequest({required String email}) async {
    return authService.sendPasswordResetRequest(email: email);
  }

  @override
  Future<void> logOut() async {
    authService.logOut();
  }
}
