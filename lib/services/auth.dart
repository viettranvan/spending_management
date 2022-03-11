
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/models.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      var idTokenResult = await userCredential.user?.getIdTokenResult();
      String uid = userCredential.user?.uid ?? '';
      String token = idTokenResult!.token ?? '';
      int expirationTime = idTokenResult.expirationTime!.millisecondsSinceEpoch;

      return Authentication(
          uid: uid, token: token, expiredToken: expirationTime);
    } on FirebaseAuthException catch (e) {
      return e;
    } catch (e) {
      debugPrint('error: $e');
    }
  }

  Future createUserWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      var idTokenResult = await userCredential.user?.getIdTokenResult();
      String uid = userCredential.user?.uid ?? '';
      String token = idTokenResult!.token ?? '';
      int expirationTime = idTokenResult.expirationTime!.millisecondsSinceEpoch;

      return Authentication(
          uid: uid, token: token, expiredToken: expirationTime);
    } on FirebaseAuthException catch (e) {
      debugPrint('code: ${e.code}');

      return e;
    } catch (e) {
      debugPrint('error: $e');
    }
  }

  Future signOut() async => _auth.signOut();

  Future sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return;
    } on FirebaseAuthException catch (e) {
      return e;
    } catch (e) {
      debugPrint('error: $e');
    }
  }

}
