import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spending_management/UI/home_page/bloc/home_bloc.dart';
import 'package:spending_management/UI/profile_page/bloc/profile_bloc.dart';

import 'home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc()..add(HomeStarted()),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(),
        )
      ],
      child: const HomeView(),
    );
  }
}
