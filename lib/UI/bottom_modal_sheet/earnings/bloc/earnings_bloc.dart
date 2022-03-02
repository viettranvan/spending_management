import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'earnings_event.dart';
part 'earnings_state.dart';

class EarningsBloc extends Bloc<EarningsEvent, EarningsState> {
  EarningsBloc() : super(EarningsInitial()) {
    on<EarningsEvent>((event, emit) {
    });
  }
}
