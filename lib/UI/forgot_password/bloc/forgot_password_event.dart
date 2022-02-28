part of 'forgot_password_bloc.dart';

@immutable
abstract class ForgotPasswordEvent {}

class SendEmailRequest extends ForgotPasswordEvent{
  final String email;
  SendEmailRequest({required this.email});
}