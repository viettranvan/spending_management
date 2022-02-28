import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../services/services.dart';
import '../../../utils/utils.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthService authService;

  final emailController = TextEditingController();
  ForgotPasswordBloc({required this.authService})
      : super(ForgotPasswordInitial()) {
    on<SendEmailRequest>(_onSendEmailRequest);
  }

  _onSendEmailRequest(
      SendEmailRequest event, Emitter<ForgotPasswordState> emit) async {
    try {
      if (event.email.isEmpty) {
        emit(SendEmailFailure(errorMessage: 'Email is required!'));
      } else if (!Validation().validatorEmail(event.email)) {
        emit(SendEmailFailure(errorMessage: 'Incorrect email format!'));
      } else {
        var obj = await authService.sendPasswordResetEmail(event.email);
        if (obj.runtimeType == FirebaseAuthException) {
          emit(SendEmailFailure(
              errorMessage: checkFirebaseAuthExceptionError(obj)));
        } else {
          emit(SendEmailSuccess());
        }
      }
    } catch (e) {
      debugPrint('error: $e');
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();

    return super.close();
  }
}
