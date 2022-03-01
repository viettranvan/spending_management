import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'main_page_event.dart';
part 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  MainPageBloc() : super(const HomePageState()) {
    on<OnChangeTab>(_onChangeTab);
  }

  _onChangeTab(OnChangeTab event, Emitter<MainPageState> emit) {
    switch (event.index) {
      case 0:
        emit(const HomePageState());
        break;
      case 2:
        emit(const SettingPageState());
        break;
      default:
        break;
    }
  }
}
