part of 'edit_spending_bloc.dart';

@immutable
abstract class EditSpendingState {}

class EditSpendingInitial extends EditSpendingState {}

class DataLoaded extends EditSpendingState {
  final HomeSpending? homeSpending;
  final String? money;
  final DateTime? chooseDay;
  final SpendingModel? spendingType;
  DataLoaded({
    this.homeSpending,
    this.money,
    this.chooseDay,
    this.spendingType,
  });

  DataLoaded update({HomeSpending? homeSpending,String? money, DateTime? chooseDay, SpendingModel? spendingType}){
    return DataLoaded(
      homeSpending: homeSpending ?? this.homeSpending,
      money: money  ?? this.money,
      chooseDay: chooseDay ?? this.chooseDay,
      spendingType: spendingType ?? this.spendingType
    );
  }

  
}
