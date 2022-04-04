import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/logic/providers/notifiers/auth_notifier.dart';

final loginScreenController =
    StateNotifierProvider.autoDispose<LoginScreenController, LoginState>((ref) {
  return LoginScreenController(ref.read);
});

class LoginScreenController extends StateNotifier<LoginState> {
  Reader read;

  LoginScreenController(this.read, [LoginState? state]) : super(InitialState());

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    state = Signin();
    await read(authNotifier.notifier)
        .signInWithEmailAndPassword(email: email, password: password);

    if (read(authNotifier) != null) {
      state = AuthSuccess();
    } else {
      state = InitialState();
    }
  }

  Future<void> signInWithGoogle() async {
    await read(authNotifier.notifier).signInWithGoogle();
    if (read(authNotifier) != null) {
      state = AuthSuccess();
    }
  }
}

class LoginState {}

class InitialState extends LoginState {}

class Signin extends LoginState {}

class AuthSuccess extends LoginState {}
