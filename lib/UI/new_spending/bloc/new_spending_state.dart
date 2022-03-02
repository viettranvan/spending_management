part of 'new_spending_bloc.dart';

@immutable
abstract class NewSpendingState {}

class NewSpendingInitial extends NewSpendingState {
  final String money;
  NewSpendingInitial({required this.money});

  NewSpendingInitial update({String? money}){
    return NewSpendingInitial(
      money: money  ?? this.money
    );
  }
}
