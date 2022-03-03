part of 'new_spending_bloc.dart';

@immutable
abstract class NewSpendingState {}

class NewSpendingInitial extends NewSpendingState {
  final String money;
  final String? chooseDay;

  NewSpendingInitial({required this.money, this.chooseDay});

  NewSpendingInitial update({String? money, String? chooseDay}){
    return NewSpendingInitial(
      money: money  ?? this.money,
      chooseDay: chooseDay ?? this.chooseDay
    );
  }
}
