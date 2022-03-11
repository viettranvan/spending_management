import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../models/models.dart';
import '../../../../../services/services.dart';
import '../../../../../utils/utils.dart';

part 'finger_modal_bs_event.dart';
part 'finger_modal_bs_state.dart';

class FingerModalBsBloc extends Bloc<FingerModalBsEvent, FingerModalBsState> {
  final TextEditingController passwordController = TextEditingController();

  FingerModalBsBloc() : super(FingerModalBsInitial()) {
    on<ConfirmAccount>(_onConfirmAccount);
  }

  _onConfirmAccount(
      ConfirmAccount event, Emitter<FingerModalBsState> emit) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      var authenticationObj = await AuthService().signInWithEmailAndPassword(
          _auth.currentUser?.email ?? '', event.password);
      if (authenticationObj.runtimeType == Authentication) {
        emit( Success(password: event.password));
      } else if (authenticationObj.runtimeType == FirebaseAuthException) {
        emit(
          Failure(
            errorText: checkFirebaseAuthExceptionError(authenticationObj),
          ),
        );
      }
    } catch (e) {
      emit(Failure(
        errorText: e.toString(),
      ));
    }
  }

  @override
  Future<void> close() {
    passwordController.dispose();
    return super.close();
  }
}
