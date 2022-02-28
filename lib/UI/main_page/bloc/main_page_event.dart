part of 'main_page_bloc.dart';

@immutable
abstract class MainPageEvent {}
class OnChangeTab extends MainPageEvent {
  final int index;

  OnChangeTab({ required this.index});
}