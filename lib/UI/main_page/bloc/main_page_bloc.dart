import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'main_page_event.dart';
part 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  MainPageBloc() : super(const HomePage()) {
    on<OnChangeTab>(_onChangeTab);
  }

  _onChangeTab(OnChangeTab event, Emitter<MainPageState> emit) {
    switch (event.index) {
      case 0:
        emit(const HomePage());
        break;
      case 1:
        emit(const AddPage());
        break;
      case 2:
        emit(const SettingPage());
        break;
      default:
        emit(const HomePage());
        break;
    }
  }
}
