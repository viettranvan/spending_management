part of 'spending_bloc.dart';

@immutable
abstract class SpendingState {}

class SpendingInitial extends SpendingState {

  final List<SpendingModel> lists;
  SpendingInitial({required this.lists});

  SpendingInitial update({List<SpendingModel>? lists}){
    return SpendingInitial(lists: lists ?? this.lists);
  }
}
