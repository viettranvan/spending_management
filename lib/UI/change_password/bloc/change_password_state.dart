part of 'change_password_bloc.dart';

@immutable
abstract class ChangePasswordState {}

class ChangePasswordInitial extends ChangePasswordState {}

class ErrorIsClear extends ChangePasswordState{}

class ChangePasswordSuccess extends ChangePasswordState{}

class ChangePasswordFailure extends ChangePasswordState{
  final String errorMessage;
  ChangePasswordFailure({required this.errorMessage});
}
