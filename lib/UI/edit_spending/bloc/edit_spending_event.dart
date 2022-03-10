part of 'edit_spending_bloc.dart';

@immutable
abstract class EditSpendingEvent {}

class FetchedData extends EditSpendingEvent{
  final String itemId;
  FetchedData({required this.itemId});
}