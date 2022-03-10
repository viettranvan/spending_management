import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/edit_spending_bloc.dart';
import 'edit_spending_view.dart';


class EditSpendingPage extends StatelessWidget {
  static const String id = 'edit_spending';
  const EditSpendingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditSpendingBloc(),
      child:  EditSpendingView(),
    );
  }
}
