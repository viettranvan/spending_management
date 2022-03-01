import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'new_spending_event.dart';
part 'new_spending_state.dart';

class NewSpendingBloc extends Bloc<NewSpendingEvent, NewSpendingState> {
  NewSpendingBloc() : super(NewSpendingInitial()) {
    on<NewSpendingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
