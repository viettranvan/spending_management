import 'package:flutter/material.dart';
import 'package:spending_management/UI/auth/sign_in/view/sign_in_page.dart';

import '../../../services/services.dart';
import '../../../utils/utils.dart';
import '../../main_page/view/main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogin = false;

  @override
  void initState() {
    HelperSharedPreferences.getLogin().then((value) {
      isLogin = value ?? false;
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    checkLogin();
    super.didChangeDependencies();
  }

  void checkLogin() {
    HelperSharedPreferences.getExpirationTime().then((value) {
      int timeNow = DateTime.now().millisecondsSinceEpoch;
      Future.delayed(const Duration(seconds: 3)).then((_) {
        if (value != null && value >= timeNow && isLogin && value != -1) {
          Navigator.pushNamedAndRemoveUntil(
              context, MainPage.id, (Route<dynamic> route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, SignInPage.id, (Route<dynamic> route) => false);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10.0),
          Center(
            child: Text(
              'SPENDING MANAGEMENT',
              textAlign: TextAlign.center,
              style: kTextSize30w400White.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Center(
            child: SizedBox(
              height: 150.0,
              width: 150.0,
              child: Image.asset(
                'assets/images/icon_app.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text('Quản lý chi tiêu của bạn',
                textAlign: TextAlign.center,
                style: kTextSize30w400White.copyWith(
                  fontWeight: FontWeight.bold,
                )),
          )),
          const SizedBox(height: 20.0),
          SizedBox(
            height: 50.0,
            width: 50.0,
            child: Image.asset(
              'assets/images/image_placeholder.gif',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
