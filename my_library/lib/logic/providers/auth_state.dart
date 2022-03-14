import 'dart:developer';

import 'package:authentication/network/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:authentication/exceptions/auth_exception.dart';
import 'package:my_library/data/repository/auth/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(authService: AuthService());
});

final authStateProvider =
    StateNotifierProvider<AuthStateProvider, User?>((ref) {
  return AuthStateProvider(ref.read);
});

final authExceptionProvider = StateProvider.autoDispose<AuthException?>((ref) {
  return null;
});

class AuthStateProvider extends StateNotifier<User?> {
  AuthStateProvider(this.read, [User? user]) : super(null) {
    log('curent ');
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

      log('? should gance');
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
    read(authRepositoryProvider).logOut();
    state = null;
  }

  void _handleError(AuthException exception) {
    read(authExceptionProvider.notifier).state = exception;
  }
}
