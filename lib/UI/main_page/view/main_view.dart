import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spending_management/UI/main_page/bloc/main_page_bloc.dart';
import 'package:spending_management/UI/new_spending/view/new_spending_page.dart';

import '../../../utils/utils.dart';
import '../../home_page/view/home_page.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  gotoNewSpending(BuildContext context) {
    Navigator.of(context).pushNamed(NewSpendingPage.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainPageBloc, MainPageState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.indexOfIndexedStack,
            children: [
              const HomePage(),
              DefaultTabController(
                length: 4,
                initialIndex: 0,
                child: Column(
                  children: [
                    const TabBar(
                      labelColor: Colors.black45,
                      tabs: [
                        Padding(
                            padding: EdgeInsets.only(top: 12, bottom: 12),
                            child: Text('green')),
                        Padding(
                            padding: EdgeInsets.only(top: 12, bottom: 12),
                            child: Text('red')),
                        Padding(
                            padding: EdgeInsets.only(top: 12, bottom: 12),
                            child: Text('yellow')),
                        Padding(
                            padding: EdgeInsets.only(top: 12, bottom: 12),
                            child: Text('cyan')),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Container(
                            color: Colors.green,
                            child: const Center(
                              child: Text('heelo'),
                            ),
                          ),
                          Container(color: Colors.red),
                          Container(color: Colors.yellow),
                          Container(color: Colors.cyan),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
                  gotoNewSpending(context);
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
