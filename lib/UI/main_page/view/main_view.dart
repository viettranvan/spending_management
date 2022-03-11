import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spending_management/UI/main_page/bloc/main_page_bloc.dart';

import '../../home_page/view/home_page.dart';
import '../../new_spending/view/new_spending_page.dart';
import '../../profile_page/view/profile_page.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  gotoNewSpending(BuildContext context) async {
    Navigator.of(context).pushNamed(NewSpendingPage.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainPageBloc, MainPageState>(
      builder: (context, state) {
        return Scaffold(
          body: BlocBuilder<MainPageBloc, MainPageState>(
            builder: (context, state) {
              if (state is HomePageState) {
                return const HomePage();
              } else if (state is SettingPageState) {
                return const ProfilePage();
              }
              return Center(
                child: SizedBox(
                  height: 50.0,
                  width: 50.0,
                  child: Image.asset(
                    'assets/images/image_placeholder.gif',
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              gotoNewSpending(context);
            },
            elevation: 5.0,
            highlightElevation: 5.0,
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 10.0,
            child: SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => BlocProvider.of<MainPageBloc>(context)
                        .add(OnChangeTab(index: 0)),
                    child: Icon(
                      Icons.home,
                      size: state.indexOfBottomNavigationBar == 0 ? 45.0 : 35,
                      color: state.indexOfBottomNavigationBar == 0
                          ? Colors.red
                          : Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => BlocProvider.of<MainPageBloc>(context)
                        .add(OnChangeTab(index: 1)),
                    child: Icon(
                      Icons.person,
                      size: state.indexOfBottomNavigationBar == 1 ? 45.0 : 35,
                      color: state.indexOfBottomNavigationBar == 1
                          ? Colors.red
                          : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // BottomNavigationBar(
          //   items: getItems(),
          //   currentIndex: state.indexOfBottomNavigationBar,
          //   showSelectedLabels: false,
          //   showUnselectedLabels: false,
          //   backgroundColor: AppColor.black25,
          //   type: BottomNavigationBarType.fixed,
          //   onTap: (index) {
          //     BlocProvider.of<MainPageBloc>(context)
          //             .add(OnChangeTab(index: index));
          //   },
          // ),
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
            Icons.person,
            size: 35.0,
            color: Colors.red,
          ),
          icon: Icon(Icons.person, size: 35.0, color: Colors.white),
          label: '',
          tooltip: '',
        ),
      ];
}
