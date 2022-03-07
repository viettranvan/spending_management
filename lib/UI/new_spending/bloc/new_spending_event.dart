part of 'new_spending_bloc.dart';

@immutable
abstract class NewSpendingEvent {}

class MoneyChange extends NewSpendingEvent {
  final String money;

  MoneyChange({required this.money});
}

class PickDate extends NewSpendingEvent {
  final DateTime date;

  PickDate({required this.date});
}

class PickSpendingType extends NewSpendingEvent {
  final SpendingModel? spendingModel;

  PickSpendingType({required this.spendingModel});
}