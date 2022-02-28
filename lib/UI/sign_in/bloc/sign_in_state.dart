part of 'sign_in_bloc.dart';

@immutable
abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInSuccess extends SignInState{
  final Authentication authentication;
  SignInSuccess({required this.authentication});
}

class EmailIsNotVerify extends SignInState{}

class SignInFailure extends SignInState{
  final String errorMessage;
  SignInFailure({required this.errorMessage});
}