import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spending_management/UI/main_page/bloc/main_page_bloc.dart';
import 'package:spending_management/UI/main_page/view/main_view.dart';


class MainPage extends StatelessWidget {
  static const String id = 'main_page';
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainPageBloc(),
      child: const MainView(),
    );
  }
}
