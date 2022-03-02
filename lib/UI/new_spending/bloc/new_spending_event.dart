part of 'new_spending_bloc.dart';

@immutable
abstract class NewSpendingEvent {}

class MoneyChange extends NewSpendingEvent {
  final String money;

  MoneyChange({required this.money});

  
}
