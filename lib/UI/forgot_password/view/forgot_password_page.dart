import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spending_management/UI/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:spending_management/UI/forgot_password/view/forgot_password_view.dart';
import 'package:spending_management/services/auth.dart';

class ForgotPasswordPage extends StatelessWidget {
  static const String id = 'forgot_password';
  const ForgotPasswordPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordBloc(authService: AuthService()),
      child: const ForgotPasswordView(),
    );
  }
}