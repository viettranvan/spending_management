import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final TextEditingController currentController = TextEditingController();
  final TextEditingController newController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  ChangePasswordBloc() : super(ChangePasswordInitial()) {
    on<OnChangePasswordEvent>(_onChangePasswordEvent);
    on<CheckErrorEvent>(_onCheckErrorEvent);
  }

  _onCheckErrorEvent(
      CheckErrorEvent event, Emitter<ChangePasswordState> emit) async {
    try {
      if (event.currentPassword.isEmpty) {
         emit(
              ChangePasswordFailure(errorMessage: 'Vui lòng nhập mật khẩu hiện tại!'));
      } else {
        bool check =
            await checkCurrentPassword(event.user!, event.currentPassword);
        if (!check) {
          emit(
              ChangePasswordFailure(errorMessage: 'Mật khẩu không chính xác!'));
        } else {
          String validateResult = validatePassword(event.newPassword);
          if (validateResult.isNotEmpty) {
            emit(ChangePasswordFailure(errorMessage: validateResult));
          } else {
            if (event.newPassword != event.confirmPassword) {
              emit(ChangePasswordFailure(
                  errorMessage: 'Mật khẩu không trùng khớp!'));
            } else {
              emit(ErrorIsClear());
            }
          }
        }
      }
    } catch (_) {
      emit(ChangePasswordFailure(
          errorMessage: 'Đổi mật khẩu không thành công!'));
    }
  }

  _onChangePasswordEvent(
      OnChangePasswordEvent event, Emitter<ChangePasswordState> emit) async {
    try {
      // UserAPI userAPI = UserAPI();
      await updatePassword(event.user!, event.newPassword);
      emit(ChangePasswordSuccess());
    } catch (_) {
      emit(ChangePasswordFailure(
          errorMessage: 'Đổi mật khẩu không thành công!'));
    }
  }

  updatePassword(User user, String newPassword) async {
    try {
      await user.updatePassword(newPassword);
    } catch (error, stacktrace) {
      throw Exception("Exception: $error, stacktrace: $stacktrace");
    }
  }

  Future<bool> checkCurrentPassword(User user, String currentPassword) async {
    try {
      final auth = FirebaseAuth.instance;
      String? email = auth.currentUser?.email;
      if (email != null) {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: email, password: currentPassword);
        switch (userCredential.user == null) {
          case true:
            return false;
          case false:
            if (userCredential.user?.uid == user.uid) {
              return true;
            }
            break;
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  String validatePassword(String password) {
    String result = '';
    if (password.isEmpty) {
      result = 'Vui lòng nhập mật khẩu mới!';
    } else if (!Validation().validatorPassword(password)) {
      result =
          'Mật khẩu phải chứa Chữ thường, In hoa, Số, Kí tự đặc biệt và ít nhất 6 ký tự.)';
    } else {
      result = '';
    }

    return result;
  }

  @override
  Future<void> close() {
    currentController.dispose();
    newController.dispose();
    confirmController.dispose();

    return super.close();
  }
}
