import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'spending_event.dart';
part 'spending_state.dart';

class SpendingBloc extends Bloc<SpendingEvent, SpendingState> {
  SpendingBloc() : super(SpendingInitial()) {
    on<SpendingEvent>((event, emit) {
    });
  }
}
