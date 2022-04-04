import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/logic/providers/notifiers/auth_notifier.dart';

final loginScreenController =
    ChangeNotifierProvider.autoDispose<LoginScreenController>((ref) {
  return LoginScreenController(ref.read);
});

class LoginScreenController extends ChangeNotifier {
  LoginScreenController(this.read) : super();
  Reader read;
  bool isSignIn = false;
  bool isGoogleSigninIn = false;
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    isSignIn = true;
    notifyListeners();
    await read(authNotifier.notifier)
        .signInWithEmailAndPassword(email: email, password: password);
    if (read(authNotifier) == null) {
      isSignIn = false;
    }
    notifyListeners();
  }

  Future<void> signInWithGoogle() async {
    await read(authNotifier.notifier).signInWithGoogle();
    if (read(authNotifier) == null) {}
  }
}
