import 'package:flutter/material.dart';
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
            email: '',
            password: '',
            formKey: GlobalKey<FormState>(),
            isSigninIn: false,
            isSuccess: false));

  Future<void> signUp({required String email, required String password}) async {
    state.formKey.currentState!.save();
    state = state.copyWith(
        email: email, password: password, isSigninIn: true, isSuccess: false);
    await read(authNotifier.notifier)
        .signUpWithEmailAndPassword(email: email, password: password)
        .then((value) {
      state = state.copyWith(isSuccess: true);
    }).onError((error, stackTrace) {
      state = state.copyWith(isSuccess: false);
    });
  }
}

class SignUpState {
  String email;
  String password;
  bool isSigninIn;
  GlobalKey<FormState> formKey;
  bool isSuccess;
  SignUpState({
    required this.email,
    required this.password,
    required this.isSigninIn,
    required this.formKey,
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
        formKey: formKey);
  }
}
