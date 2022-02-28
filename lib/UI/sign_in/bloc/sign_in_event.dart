part of 'sign_in_bloc.dart';

@immutable
abstract class SignInEvent {}


class SendLoginRequest extends SignInEvent{
  final String email;
  final String password;
  SendLoginRequest({required this.email,required this.password});
}