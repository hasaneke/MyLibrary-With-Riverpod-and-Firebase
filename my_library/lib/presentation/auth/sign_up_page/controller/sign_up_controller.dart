import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:my_library/logic/providers/notifiers/auth_notifier.dart';

final signUpController =
    StateNotifierProvider.autoDispose<SignUpController, SignUpState>((ref) {
  return SignUpController(ref.read);
});

class SignUpController extends StateNotifier<SignUpState> {
  Reader read;

  SignUpController(this.read, [SignUpState? state])
      : super(SignUpState(
            email: '', password: '', isSigninIn: false, isSuccess: false));

  Future<void> signUp({required String email, required String password}) async {
    state = state.copyWith(
        email: email, password: password, isSigninIn: true, isSuccess: false);
    await read(authNotifier.notifier)
        .signUpWithEmailAndPassword(email: email, password: password);
    if (read(authNotifier) != null) {
      state = state.copyWith(isSuccess: true);
    } else {
      state = state.copyWith(isSuccess: false, isSigninIn: false);
    }
  }
}

class SignUpState {
  String email;
  String password;
  bool isSigninIn;
  bool isSuccess;
  SignUpState({
    required this.email,
    required this.password,
    required this.isSigninIn,
    required this.isSuccess,
  });

  SignUpState copyWith({
    String? email,
    String? password,
    bool? isSigninIn,
    bool? isSuccess,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      isSigninIn: isSigninIn ?? this.isSigninIn,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
