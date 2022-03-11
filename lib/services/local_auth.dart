import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuth {
  static final _auth = LocalAuthentication();

  static Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  static Future<bool> authenticate(String email) async {
    final isAvailable = await hasBiometrics();
    if (!isAvailable) {
      return false;
    }
    try {
      return await _auth.authenticate(
        biometricOnly: true,
        localizedReason: 'Quét vân tay, đăng nhập cho tài khoản: $email',
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      debugPrint('authenticate error: ' + e.toString());
      return false;
    }
  }
}
