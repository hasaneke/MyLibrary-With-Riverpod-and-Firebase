import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/logic/providers/notifiers/auth_notifier.dart';

final signUpController = ChangeNotifierProvider.autoDispose((ref) {
  return SignUpController(ref.read);
});

class SignUpController extends ChangeNotifier {
  Reader read;

  SignUpController(this.read, [state]) : super();

  bool isSigningUp = false;
  Future<void> signUp({required String email, required String password}) async {
    //read(isSigningUp.notifier).state = true;
    isSigningUp = true;
    notifyListeners();
    await read(authNotifier.notifier)
        .signUpWithEmailAndPassword(email: email, password: password);

    if (read(authNotifier) == null) {
      //read(isSigningUp.notifier).state = false;
      isSigningUp = false;
    }
    notifyListeners();
  }
}
