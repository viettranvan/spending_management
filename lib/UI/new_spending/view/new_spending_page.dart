import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spending_management/UI/new_spending/bloc/new_spending_bloc.dart';
import 'package:spending_management/UI/new_spending/view/new_spending_view.dart';
class NewSpendingPage extends StatelessWidget {
  static const String id = 'new_speding';
  const NewSpendingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewSpendingBloc(),
      child:  NewSpendingView(),
    );
  }
}
