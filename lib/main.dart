import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:spending_management/UI/main_page/view/main_page.dart';
import 'package:spending_management/UI/sign_up/view/sign_up_page.dart';
import 'UI/forgot_password/view/forgot_password_page.dart';

import 'UI/sign_in/view/sign_in_page.dart';
import 'utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const SpendingManagement());
  
}

class SpendingManagement extends StatelessWidget{
  const SpendingManagement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spending Management App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.dark,
          fontFamily: "Lato",
          scaffoldBackgroundColor: AppColor.background),
      home: const SignInPage(),
      routes: {
        SignInPage.id: (context) => const SignInPage(),
        SignUpPage.id: (context) => const SignUpPage(),
        ForgotPasswordPage.id: (context) => const ForgotPasswordPage(),
        MainPage.id: (context) => const MainPage(),
      },
    );
  }

}