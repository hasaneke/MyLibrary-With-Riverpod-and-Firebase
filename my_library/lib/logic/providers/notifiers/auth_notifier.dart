import 'dart:developer';

import 'package:authentication/network/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:authentication/exceptions/auth_exception.dart';
import 'package:my_library/data/repository/auth/auth_repository.dart';
import 'package:my_library/logic/providers/notifiers/cards_notifier.dart';
import 'package:my_library/logic/providers/notifiers/categories_notifier.dart';
import 'package:my_library/logic/providers/state_providers/expection_providers.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(authService: AuthService());
});

final authNotifier = StateNotifierProvider<AuthNotifier, User?>((ref) {
  return AuthNotifier(ref.read);
});

class AuthNotifier extends StateNotifier<User?> {
  AuthNotifier(this.read, [User? user]) : super(null) {
    getCurrentUser();
  }
  final Reader read;
  Future<void> getCurrentUser() async {
    try {
      final currentUser = await read(authRepositoryProvider).getCurrentUser();
      state = currentUser;
    } on FirebaseAuthException catch (e) {
      log(e.message!);
      _handleError(AuthException(code: e.code));
    } on PlatformException catch (e) {
      _handleError(AuthException(code: e.code));
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final user = await read(authRepositoryProvider).signInWithGoogle();
      state = user;
    } on FirebaseAuthException catch (e) {
      log(e.code);
      _handleError(AuthException(code: e.code));
    } on PlatformException catch (e) {
      log(e.code);
      _handleError(AuthException(code: e.code));
    }
  }

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      state = await read(authRepositoryProvider)
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      _handleError(AuthException(code: e.code));
    } on PlatformException catch (e) {
      _handleError(AuthException(code: e.code));
    }
  }

  Future<void> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final user = await read(authRepositoryProvider)
          .signUpWithEmailAndPassword(email: email, password: password);
      state = user;
    } on FirebaseAuthException catch (e) {
      _handleError(AuthException(code: e.code));
    } on PlatformException catch (e) {
      _handleError(AuthException(code: e.code));
    }
  }

  Future<bool> sendPasswordResetRequest({required String email}) async {
    try {
      final succeed = await read(authRepositoryProvider)
          .sendPasswordResetRequest(email: email);
      log(succeed.toString());
      return succeed;
    } on FirebaseAuthException catch (e) {
      _handleError(AuthException(code: e.code));
      log(e.message!);
      return false;
    } on PlatformException catch (e) {
      _handleError(AuthException(code: e.code));
      return false;
    }
  }

  Future<void> logOut() async {
    read(cardsNotifier.notifier).mounted
        ? null
        : read(cardsNotifier.notifier).dispose();
    await read(authRepositoryProvider).logOut();
    state = null;
  }

  void _handleError(AuthException exception) {
    read(authExceptionProvider.notifier).state = exception;
  }
}
