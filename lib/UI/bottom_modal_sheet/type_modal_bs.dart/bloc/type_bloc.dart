import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'type_event.dart';
part 'type_state.dart';

class TypeBloc extends Bloc<TypeEvent, TypeState> {
  TypeBloc() : super(const TypeInitial()) {
    on<ChangeTab>(_onChangeTab);
  }

  _onChangeTab(ChangeTab event, Emitter<TypeState> emit) {
    switch (event.index) {
      case 0:
        emit(const Spending());
        break;
      case 1:
        emit(const Earnings());
        break;
      default:
        break;
    }
  }
}
