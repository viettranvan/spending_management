import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'utils.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

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

String getDateNow() {
  String result = '';
  initializeDateFormatting();
  // DateTime now = DateTime.now();
  DateTime now = DateTime.now();
  switch (DateFormat('EEEE').format(now)) {
    case 'Monday':
      result += 'Thứ hai';
      break;
    case 'Tuesday':
      result += 'Thứ ba';
      break;
    case 'Wednesday':
      result += 'Thứ tư';
      break;
    case 'Thursday':
      result += 'Thứ năm';
      break;
    case 'Friday':
      result += 'Thứ sáu';
      break;
    case 'Saturday':
      result += 'Thứ bảy';
      break;
    case 'Sunday':
      result += 'Chủ nhật';
      break;
  }
  String dayInMonth = now.day.toString();
  String month = now.month.toString();
  String year = now.year.toString();
  result += ' , $dayInMonth tháng $month năm $year';
  return result;
}

String formatMoney(String moneyString) {
  try {
    String result = '';
    String validateMoney = moneyString.replaceAll(RegExp(r"\D"), "");
    int money = int.parse(validateMoney);
    result = NumberFormat.currency(locale: 'vi').format(money);
    return result;
  } catch (e) {
    return '';
  }
}
