import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spending_management/UI/change_password/view/change_password_view.dart';

import '../bloc/change_password_bloc.dart';

class ChangePasswordPage extends StatelessWidget {
  static const String id = 'change_password';

  const ChangePasswordPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordBloc(),
      child: const ChangePasswordView(),
    );
  }
}