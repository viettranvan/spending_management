import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'new_spending_event.dart';
part 'new_spending_state.dart';

class NewSpendingBloc extends Bloc<NewSpendingEvent, NewSpendingState> {
  final moneyController = TextEditingController();
  NewSpendingBloc() : super(NewSpendingInitial(money: '')) {
    on<MoneyChange>(_onMoneyChange);
  }

  _onMoneyChange(MoneyChange event, Emitter<NewSpendingState> emit) {
    var currentState = state;
    if(currentState is NewSpendingInitial){
      
      emit(currentState.update(money: event.money));
    }
  }

  @override
  Future<void> close() {
    moneyController.dispose();
    return super.close();
  }
}
