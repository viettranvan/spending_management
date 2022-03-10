part of 'edit_spending_bloc.dart';

@immutable
abstract class EditSpendingEvent {}

class FetchedData extends EditSpendingEvent{
  final String itemId;
  FetchedData({required this.itemId});
}

class MoneyChange extends EditSpendingEvent {
  final String money;

  MoneyChange({required this.money});
}

class PickDate extends EditSpendingEvent {
  final DateTime date;

  PickDate({required this.date});
}

class PickSpendingType extends EditSpendingEvent {
  final SpendingModel? spendingModel;

  PickSpendingType({required this.spendingModel});
}