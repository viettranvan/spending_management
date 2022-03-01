import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spending_management/UI/main_page/bloc/main_page_bloc.dart';

import '../../../utils/utils.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainPageBloc, MainPageState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.indexOfIndexedStack,
            children: const [
              Center(child: Text('home')),
              Center(child: Text('home2')),
              Center(child: Text('home3')),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: getItems(),
            currentIndex: state.indexOfBottomNavigationBar,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: AppColor.background,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              switch (index) {
                case 1:
                  print('index == 1, add');
                  break;
                default:
                  BlocProvider.of<MainPageBloc>(context)
                      .add(OnChangeTab(index: index));
              }
            },
          ),
        );
      },
    );
  }

  List<BottomNavigationBarItem> getItems() => [
        const BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.home,
            size: 35.0,
            color: Colors.red,
          ),
          icon: Icon(Icons.home, size: 35.0, color: Colors.white),
          label: '',
          tooltip: '',
        ),
        const BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.add,
            size: 35.0,
            color: Colors.red,
          ),
          icon: Icon(Icons.add, size: 35.0, color: Colors.white),
          label: '',
          tooltip: '',
        ),
        const BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.settings,
            size: 35.0,
            color: Colors.red,
          ),
          icon: Icon(Icons.settings, size: 35.0, color: Colors.white),
          label: '',
          tooltip: '',
        ),
      ];
}
