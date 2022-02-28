import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'utils.dart';

DateTime? currentBackPressTime;

Future<bool> onWillPop(BuildContext context) {
  DateTime now = DateTime.now();
  if (currentBackPressTime == null ||
      now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
    currentBackPressTime = now;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Press back again to exit', style: kTextSize18w400White),
      backgroundColor: AppColor.background,
    ));
    return Future.value(false);
  }
  return Future.value(true);
}

String checkFirebaseAuthExceptionError(FirebaseAuthException error) {
  String result = '';
  switch (error.code) {
    case 'user-not-found':
      result = 'Your email provided is not registered!';
      break;
    case 'wrong-password':
      result = 'Your password is incorrect!';
      break;
    case 'invalid-email':
      result = 'Invalid email!';
      break;
    case 'email-already-in-use':
      result = 'Email already in use. reset your password or log in!';
      break;
    default:
      result = 'Login information is incorrect!';
  }
  return result;
  
}