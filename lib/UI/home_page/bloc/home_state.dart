part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoaded extends HomeState{
  final List<HomeSpending> lists;

  HomeLoaded({required this.lists});
}