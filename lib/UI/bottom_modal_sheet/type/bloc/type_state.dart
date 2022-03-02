part of 'type_bloc.dart';

@immutable
abstract class TypeState {
  final int index;
  const TypeState({required this.index});
}

class TypeInitial extends TypeState {
  const TypeInitial() : super(index: 0);
}

class Spending extends TypeState{
  const Spending() : super(index: 0);

}

class Earnings extends TypeState{
  const Earnings() : super(index: 1);
  
}

