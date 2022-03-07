part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoaded extends HomeState{
  final List<HomeSpending> lists;
  final int totalSpent;
  final int totalEarn;

  HomeLoaded({required this.lists,required this.totalSpent, required this.totalEarn});
}