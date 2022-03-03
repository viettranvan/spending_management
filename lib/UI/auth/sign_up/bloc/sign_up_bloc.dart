import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../models/models.dart';
import '../../../../services/services.dart';
import '../../../../utils/utils.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthService authService;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  SignUpBloc({required this.authService}) : super(SignUpInitial()) {
    on<SendSignUpRequest>(_onSendSignUpRequest);
  }

  _onSendSignUpRequest(
      SendSignUpRequest event, Emitter<SignUpState> emit) async {
    try {
      String check = checkValidate(event.email, event.password);
      if (check.isNotEmpty) {
        emit(SignUpFailure(errorMessage: check));
      } else if (event.password != event.confirm) {
        emit(SignUpFailure(errorMessage: 'Password not match!'));
      } else {
        var authenticationObj = await authService
            .createUserWithEmailAndPassword(event.email, event.password);

        if (authenticationObj.runtimeType == Authentication) {
          emit(SignUpSuccess(authentication: authenticationObj));
        } else if (authenticationObj.runtimeType == FirebaseAuthException) {
          emit(SignUpFailure(
              errorMessage:
                  checkFirebaseAuthExceptionError(authenticationObj)));
        }
      }
    } catch (e) {
      debugPrint('error: $e');
    }
  }

  String checkValidate(String email, String password) {
    String result = '';

    if (email.isEmpty && password.isEmpty) {
      result = 'Email is required\nPassword is required';
    }

    if (email.isEmpty && password.isNotEmpty) {
      result = 'Email is required';
    }

    if (email.isNotEmpty && password.isEmpty) {
      result = 'Password is required';
    }

    if (email.isNotEmpty && password.isNotEmpty) {
      if (!Validation().validatorEmail(email)) {
        result = 'Incorrect email format';
      } else if (!Validation().validatorPassword(password)) {
        result =
            'Incorrect password format\n(Must have: Upper, Lower, Number, Special, at least 6 characters.)';
      }
    }

    return result;
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    return super.close();
  }
}
