import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../models/models.dart';
import '../../../../services/services.dart';
import '../../../../utils/utils.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthService authService;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  SignInBloc({required this.authService}) : super(const SignInInitial()) {
    on<FetchData>(_onFetchData);
    on<SendLoginRequest>(_onSendLoginRequest);
  }

  _onFetchData(FetchData event, Emitter<SignInState> emit) async {
    try {
      bool? enableFinger =
          await HelperSharedPreferences.getIsFingerPrinterLogin();
      String? email = await HelperSharedPreferences.getEmail();
      String? password = await HelperSharedPreferences.getPassword();
      emit(SignInInitial(
          fingerLogin: enableFinger, email: email, password: password));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _onSendLoginRequest(SendLoginRequest event, Emitter<SignInState> emit) async {
    bool? enableFinger =
        await HelperSharedPreferences.getIsFingerPrinterLogin();
    String? email = await HelperSharedPreferences.getEmail();
    String? password = await HelperSharedPreferences.getPassword();

    try {
      String check = checkValidate(event.email, event.password);

      if (check.isNotEmpty) {
        emit(SignInFailure(
          errorMessage: check,
          fingerLogin: enableFinger,
          email: email,
          password: password,
        ));
      } else {
        var authenticationObj = await authService.signInWithEmailAndPassword(
            event.email, event.password);
        if (authenticationObj.runtimeType == Authentication) {
          emit(SignInSuccess(
            authentication: authenticationObj,
            fingerLogin: enableFinger,
            email: email,
            password: password,
          ));
        } else if (authenticationObj.runtimeType == FirebaseAuthException) {
          emit(
            SignInFailure(
              errorMessage: checkFirebaseAuthExceptionError(authenticationObj),
              fingerLogin: enableFinger,
              email: email,
              password: password,
            ),
          );
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
      } else if (password.length < 6) {
        result = 'Password at least 6 characters';
      }
    }

    return result;
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }

 
}
