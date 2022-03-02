part of 'type_bloc.dart';

@immutable
abstract class TypeEvent {}

class ChangeTab extends TypeEvent{
  final int index;
   ChangeTab({required this.index});
}