part of 'main_page_bloc.dart';

@immutable
abstract class MainPageState {
  final int indexOfIndexedStack;
  final int indexOfBottomNavigationBar;
  const MainPageState(this.indexOfIndexedStack, this.indexOfBottomNavigationBar);
}

class HomePage extends MainPageState {
  const HomePage() : super(0,0);
}

class SettingPage extends MainPageState {
  const SettingPage() : super(1,2);
}

