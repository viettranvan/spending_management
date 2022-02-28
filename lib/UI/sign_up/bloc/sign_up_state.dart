part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}


class SignUpSuccess extends SignUpState{
  final Authentication authentication;
  SignUpSuccess({required this.authentication});
}

class SignUpFailure extends SignUpState{
  final String errorMessage;
  SignUpFailure({required this.errorMessage});
}