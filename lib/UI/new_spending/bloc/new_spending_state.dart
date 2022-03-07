part of 'new_spending_bloc.dart';

@immutable
abstract class NewSpendingState {}

class NewSpendingInitial extends NewSpendingState {
  final String money;
  final DateTime? chooseDay;
  final SpendingModel? spendingType;

  NewSpendingInitial({required this.money, this.chooseDay, this.spendingType});

  NewSpendingInitial update({String? money, DateTime? chooseDay, SpendingModel? spendingType}){
    return NewSpendingInitial(
      money: money  ?? this.money,
      chooseDay: chooseDay ?? this.chooseDay,
      spendingType: spendingType ?? this.spendingType
    );
  }
}
