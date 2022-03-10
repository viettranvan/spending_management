part of 'edit_spending_bloc.dart';

@immutable
abstract class EditSpendingState {}

class EditSpendingInitial extends EditSpendingState {}

class DataLoaded extends EditSpendingState{
  final HomeSpending homeSpending;
  DataLoaded({required this.homeSpending});
}
