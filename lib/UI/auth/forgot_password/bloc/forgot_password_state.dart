part of 'forgot_password_bloc.dart';

@immutable
abstract class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}


class SendEmailSuccess extends ForgotPasswordState{}

class SendEmailFailure extends ForgotPasswordState{
  final String errorMessage;
  SendEmailFailure({required this.errorMessage});
}