part of 'main_page_bloc.dart';

@immutable
abstract class MainPageState {
  final int index;
  const MainPageState(this.index);
}

class HomePage extends MainPageState {
  const HomePage() : super(0);
}

class AddPage extends MainPageState {
  const AddPage() : super(1);
}

class SettingPage extends MainPageState {
  const SettingPage() : super(2);
}
