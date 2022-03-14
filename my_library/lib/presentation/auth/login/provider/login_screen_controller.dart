import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/logic/providers/auth_state.dart';

final loginScreenController =
    StateNotifierProvider.autoDispose<LoginScreenController, bool>((ref) {
  return LoginScreenController(ref.read);
});
final isEmailSignIn = StateProvider.autoDispose<bool>((ref) {
  return false;
});
final isGoogleSignIn = StateProvider.autoDispose<bool>((ref) {
  return false;
});

class LoginScreenController extends StateNotifier<bool> {
  LoginScreenController(this.read, [bool? state]) : super(false);
  Reader read;

  bool isGoogleSigninIn = false;
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    read(isEmailSignIn.notifier).state = true;
    await read(authStateProvider.notifier)
        .signInWithEmailAndPassword(email: email, password: password);
    if (read(authStateProvider) == null) {
      read(isEmailSignIn.notifier).state = false;
    }
  }

  Future<void> signInWithGoogle() async {
    read(isGoogleSignIn.notifier).state = true;
    await read(authStateProvider.notifier).signInWithGoogle();
    if (read(authStateProvider) == null) {
      read(isGoogleSignIn.notifier).state = false;
    }
  }
}
