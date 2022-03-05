import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spending_management/UI/change_password/bloc/change_password_bloc.dart';

import '../../../components/components.dart';
import '../../../utils/utils.dart';

class ChangePasswordView extends StatelessWidget {

  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChangePasswordBloc _bloc = BlocProvider.of<ChangePasswordBloc>(context);

    final auth = FirebaseAuth.instance;

    void onConfirmChange() {
      showDialog(context: context, barrierDismissible: false,builder: (context) => const LoadingDialog());
      BlocProvider.of<ChangePasswordBloc>(context).add(CheckErrorEvent(
        user: auth.currentUser,
        currentPassword: _bloc.currentController.text,
        newPassword: _bloc.newController.text,
        confirmPassword: _bloc.confirmController.text,
      ));
    }

    onChangePasswordSuccess(BuildContext context) {
      // back to profile page
      Navigator.of(context).pop();

      WidgetsBinding.instance!.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Mật khẩu của bạn đã được cập nhật!',
              style: kTextSize18w400White),
          backgroundColor: AppColor.background,
        ));
        // Add Your Code here.
        Navigator.of(context).pop();
      });
    }

    var changePasswordDialog = CustomDialog(
        title: 'Xác nhận đổi mật khẩu',
        content: 'Bạn có muốn thay đổi mật khẩu của mình không?',
        onSubmit: () => BlocProvider.of<ChangePasswordBloc>(context).add(
            OnChangePasswordEvent(
                user: auth.currentUser,
                newPassword: _bloc.newController.text)));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đổi mật khẩu', style: kTextSize28w500White),
        centerTitle: true,
        backgroundColor: AppColor.background,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50.0),
                BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case ChangePasswordFailure:
                        Navigator.maybePop(context);
                        return ErrorMessageBox(
                            message:
                                (state as ChangePasswordFailure).errorMessage);
                      case ErrorIsClear:
                        Navigator.maybePop(context);
                        Future.delayed(Duration.zero).then((_) {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => changePasswordDialog);
                        });

                        return const SizedBox();
                      case ChangePasswordSuccess:
                        onChangePasswordSuccess(context);

                        break;
                      default:
                        return const SizedBox();
                    }
                    return const SizedBox();
                  },
                ),
                const SizedBox(height: 20.0),
                const Text('Mật khẩu hiện tại', style: kTextSize20w400White),
                const SizedBox(height: 10.0),
                ReusableTextField(
                  controller: _bloc.currentController,
                  hintText: 'Enter your current Password',
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  suffixIcon: true,
                ),
                const SizedBox(height: 20.0),
                const Text('Mật khẩu mới', style: kTextSize20w400White),
                const SizedBox(height: 10.0),
                ReusableTextField(
                    controller: _bloc.newController,
                    hintText: 'Enter your new Password',
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                    suffixIcon: true),
                const SizedBox(height: 20.0),
                const Text('Xác nhận mật khẩu', style: kTextSize20w400White),
                const SizedBox(height: 10.0),
                ReusableTextField(
                    controller: _bloc.confirmController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    suffixIcon: true),
                const SizedBox(height: 20.0),
                ReusableButton(
                  onTap: onConfirmChange,
                  buttonTitle: 'Đổi mật khẩu',
                  buttonColor: AppColor.red,
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
