part of 'main_page_bloc.dart';

@immutable
abstract class MainPageState {
  final int indexOfIndexedStack;
  final int indexOfBottomNavigationBar;
  const MainPageState(this.indexOfIndexedStack, this.indexOfBottomNavigationBar);
}

class HomePageState extends MainPageState {
  const HomePageState() : super(0,0);
}

class SettingPageState extends MainPageState {
  const SettingPageState() : super(1,1);
}

