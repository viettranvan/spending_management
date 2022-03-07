import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:spending_management/UI/main_page/view/main_page.dart';
import 'package:spending_management/UI/splash_screen/view/splash_screen.dart';

import 'UI/auth/forgot_password/view/forgot_password_page.dart';
import 'UI/auth/sign_in/view/sign_in_page.dart';
import 'UI/auth/sign_up/view/sign_up_page.dart';
import 'UI/change_password/view/change_password_page.dart';
import 'UI/new_spending/view/new_spending_page.dart';
import 'utils/utils.dart';

void main() async {
  if (!kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //     options: const FirebaseOptions(
  //         apiKey: "AIzaSyBCRkVPq84gq3erUDtuNlLRmaYgFWgPHGk",
  //         authDomain: "spending-management-6b53f.firebaseapp.com",
  //         projectId: "spending-management-6b53f",
  //         storageBucket: "spending-management-6b53f.appspot.com",
  //         messagingSenderId: "833333651158",
  //         appId: "1:833333651158:web:03009cf3148b389d25cb77"),
  //   );

  runApp(const SpendingManagement());
}

class SpendingManagement extends StatelessWidget {
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
      home: const SplashScreen(),
      routes: {
        SignInPage.id: (context) => const SignInPage(),
        SignUpPage.id: (context) => const SignUpPage(),
        ForgotPasswordPage.id: (context) => const ForgotPasswordPage(),
        MainPage.id: (context) => const MainPage(),
        NewSpendingPage.id: (context) => const NewSpendingPage(),
        ChangePasswordPage.id: (context) => const ChangePasswordPage(),
      },
    );
  }
}
