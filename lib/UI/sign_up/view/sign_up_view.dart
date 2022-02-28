import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/components.dart';
import '../../../utils/utils.dart';
import '../../sign_in/view/sign_in_page.dart';
import '../bloc/sign_up_bloc.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignUpBloc _bloc = BlocProvider.of<SignUpBloc>(context);

    void onSingUp() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const LoadingDialog(),
      );

      _bloc.add(
        SendSignUpRequest(
            email: _bloc.emailController.text,
            password: _bloc.passwordController.text,
            confirm: _bloc.confirmController.text),
      );
    }

    void backToLogin() {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed(SignInPage.id);
      });
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10.0),
                Center(
                    child: Text('QUẢN LÝ CHI TIÊU',
                        style: kTextSize30w400White.copyWith(
                            fontWeight: FontWeight.bold))),
                Center(
                  child: SizedBox(
                    height: 150.0,
                    width: 150.0,
                    child: Image.asset(
                      'assets/images/themovie_app_icon.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Center(
                    child: Text('ĐĂNG KÝ',
                        style: kTextSize30w400White.copyWith(
                            fontWeight: FontWeight.bold))),
                const SizedBox(height: 20.0),
                BlocBuilder<SignUpBloc, SignUpState>(
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case SignUpFailure:
                        // close loading dialog
                        Navigator.maybePop(context);
                        return ErrorMessageBox(
                            message: (state as SignUpFailure).errorMessage);
                      case SignUpSuccess:
                        // close loading dialog
                        Navigator.maybePop(context);
                        backToLogin();
                        break;
                      default:
                        return const SizedBox();
                    }
                    return const SizedBox();
                  },
                ),
                const SizedBox(height: 10.0),
                const Text('Email', style: kTextSize20w400White),
                const SizedBox(height: 10.0),
                ReusableTextField(
                  hintText: 'Enter your Email',
                  controller: _bloc.emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20.0),
                const Text('Password', style: kTextSize20w400White),
                const SizedBox(height: 10.0),
                ReusableTextField(
                  hintText: 'Enter your Password',
                  controller: _bloc.passwordController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  suffixIcon: true,
                ),
                const SizedBox(height: 20.0),
                const Text('Confirm Password', style: kTextSize20w400White),
                const SizedBox(height: 10.0),
                ReusableTextField(
                  hintText: 'Confirm Password',
                  controller: _bloc.confirmController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  suffixIcon: true,
                ),
                const SizedBox(height: 20.0),
                const SizedBox(height: 20.0),
                ReusableButton(
                  onTap: () => onSingUp(),
                  buttonTitle: 'Đăng ký',
                  buttonColor: AppColor.red,
                ),
                const SizedBox(height: 20.0),
                const SizedBox(height: 20.0),
                Center(
                  child: Wrap(
                    children: [
                      const Text('Đã có tài khoản?',
                          style: kTextSize18w400White),
                      const SizedBox(width: 10.0),
                      GestureDetector(
                        onTap: () => backToLogin(),
                        child: const Text('Đăng nhập ngay',
                            style: kTextSize18w400Red),
                      ),
                    ],
                  ),
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
