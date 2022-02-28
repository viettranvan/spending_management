import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spending_management/UI/sign_in/bloc/sign_in_bloc.dart';
import 'package:spending_management/UI/sign_in/view/sign_in_view.dart';

import '../../../services/services.dart';

class SignInPage extends StatelessWidget {
  static const String id = 'sign_in';

  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(authService: AuthService()),
      child: const SignInView(),
    );
  }
}
