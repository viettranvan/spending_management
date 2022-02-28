import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spending_management/UI/sign_up/bloc/sign_up_bloc.dart';
import 'package:spending_management/UI/sign_up/view/sign_up_view.dart';
import 'package:spending_management/services/auth.dart';

class SignUpPage extends StatelessWidget {
  static const String id = 'sign_up';

  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(authService: AuthService()),
      child: const SignUpView(),
    );
  }
}
