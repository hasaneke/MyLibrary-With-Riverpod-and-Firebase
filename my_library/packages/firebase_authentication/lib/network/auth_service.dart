import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class IAuthService {
  Future<User?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    return null;
  }

  Future<User?> signInWithGoogle() async {
    return null;
  }

  Future<User?> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    return null;
  }

  Future<void> sendEmailVertification({required User user}) async {}

  Future<User?> getCurrentUser() async {
    return null;
  }

  Future<bool> sendPasswordResetRequest({required String email}) async {
    return false;
  }

  Future<void> logOut() async {}
}

class AuthService implements IAuthService {
  final _authInstance = FirebaseAuth.instance;
  @override
  Future<User?> getCurrentUser() async {
    try {
      return _authInstance.currentUser!;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> sendEmailVertification({required User user}) async {
    try {
      await user.sendEmailVerification();
    } on FirebaseAuthException {
      rethrow;
    }
  }

  @override
  Future<User?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final _credentail = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return _credentail.user;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  @override
  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final userCredential = await _authInstance.signInWithCredential(credential);
    return userCredential.user;
  }

  @override
  Future<User?> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    final usercredential = await _authInstance.createUserWithEmailAndPassword(
        email: email, password: password);
    return usercredential.user;
  }

  @override
  Future<bool> sendPasswordResetRequest({required String email}) async {
    try {
      log('heyy');
      await _authInstance.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().disconnect();
    } on PlatformException catch (e) {
      log(e.code);
    }
  }
}
