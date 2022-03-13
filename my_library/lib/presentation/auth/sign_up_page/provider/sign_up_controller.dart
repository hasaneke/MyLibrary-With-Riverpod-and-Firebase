import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/logic/providers/auth_state.dart';

final isSigningUp = StateProvider<bool>((ref) {
  return false;
});

final signUpController = StateNotifierProvider((ref) {
  return SignUpController(ref.read);
});

class SignUpController extends StateNotifier {
  Reader read;

  SignUpController(this.read, [state]) : super(state);
  Future<void> signUp({required String email, required String password}) async {
    read(isSigningUp.notifier).state = true;
    await read(authStateProvider.notifier)
        .signUpWithEmailAndPassword(email: email, password: password);

    if (read(authStateProvider) == null) {
      read(isSigningUp.notifier).state = false;
    }
  }
}
