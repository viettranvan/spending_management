part of 'finger_modal_bs_bloc.dart';

@immutable
abstract class FingerModalBsEvent {}

class ConfirmAccount extends FingerModalBsEvent{
  final String password;

  ConfirmAccount({required this.password});
}