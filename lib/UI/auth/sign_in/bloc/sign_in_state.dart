part of 'sign_in_bloc.dart';

@immutable
abstract class SignInState {
  final bool? fingerLogin;
  final String? email;
  final String? password;
  const SignInState({this.fingerLogin, this.email, this.password});
}

class SignInInitial extends SignInState {
  const SignInInitial({
    String? email,
    String? password,
    bool? fingerLogin,
  }) : super(
          fingerLogin: fingerLogin,
          email: email,
          password: password,
        );
}

class SignInSuccess extends SignInState {
  final Authentication authentication;
  const SignInSuccess({
    String? email,
    String? password,
    bool? fingerLogin,
    required this.authentication,
  }) : super(
          fingerLogin: fingerLogin,
          email: email,
          password: password,
        );
}

class SignInFailure extends SignInState {
  final String errorMessage;
  const SignInFailure({
    String? email,
    String? password,
    bool? fingerLogin,
    required this.errorMessage,
  }) : super(
          fingerLogin: fingerLogin,
          email: email,
          password: password,
        );
}
