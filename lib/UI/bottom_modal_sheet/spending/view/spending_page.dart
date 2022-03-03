import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spending_management/UI/bottom_modal_sheet/spending/view/spending_view.dart';

import '../bloc/spending_bloc.dart';

class SpendingPage extends StatelessWidget {
  const SpendingPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SpendingBloc(),
      child: const SpendingView(),
    );
  }
}