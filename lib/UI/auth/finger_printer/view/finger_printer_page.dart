import 'package:flutter/material.dart';
import 'package:spending_management/utils/app_style.dart';

class FingerPrinterPage extends StatelessWidget {
  static const String id = 'finger_printer';
  const FingerPrinterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Đăng nhập bằng vân tay',
          style: kTextSize18w400White,
        ),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Image.asset(
            'assets/images/icon_back.png',
            color: Colors.white,
          ),
        ),
        elevation: 2.0,
        shadowColor: Colors.white,
      ),
    );
  }
}
