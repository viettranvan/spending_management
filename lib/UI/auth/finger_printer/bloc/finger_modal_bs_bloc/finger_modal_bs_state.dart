part of 'finger_modal_bs_bloc.dart';

@immutable
abstract class FingerModalBsState {}

class FingerModalBsInitial extends FingerModalBsState {}

class Success extends FingerModalBsState {}

class Failure extends FingerModalBsState {
  final String errorText;
  Failure({required this.errorText});
}
