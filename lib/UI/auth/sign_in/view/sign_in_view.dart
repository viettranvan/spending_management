import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spending_management/services/local_auth.dart';
import '../../../../components/components.dart';
import '../../../../models/models.dart';
import '../../../../services/services.dart';
import '../../../../utils/utils.dart';
import '../../../main_page/view/main_page.dart';
import '../../forgot_password/view/forgot_password_page.dart';
import '../../sign_up/view/sign_up_page.dart';
import '../bloc/sign_in_bloc.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignInBloc _bloc = BlocProvider.of<SignInBloc>(context);

    void onLogin(BuildContext context) {
      String email = _bloc.emailController.text;
      String password = _bloc.passwordController.text;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const LoadingDialog(),
      );

      BlocProvider.of<SignInBloc>(context)
          .add(SendLoginRequest(email: email, password: password));
    }

    void gotoSignUp() {
      Navigator.of(context).pushNamed(SignUpPage.id);
    }

    void gotoForgotPassword() {
      Navigator.of(context).pushNamed(ForgotPasswordPage.id);
    }

    void gotoMainPage(Authentication auth) async {
      await HelperSharedPreferences.saveUid(auth.uid);
      await HelperSharedPreferences.saveToken(auth.token);
      await HelperSharedPreferences.saveExpirationTime(auth.expiredToken);
      await HelperSharedPreferences.saveLogin(true);

      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, MainPage.id);
      });
    }

    onFingerPrinterLogin(BuildContext context, SignInBloc bloc) async {
      final isAuthenticate = await LocalAuth.authenticate(bloc.state.email ?? '');
      if (isAuthenticate) {
        showDialog(
          context: context,
          builder: (context) => const LoadingDialog(),
          barrierDismissible: false,
        );
        String email = bloc.state.email ?? '';
        String password = bloc.state.password ?? '';

        bloc.add(SendLoginRequest(email: email, password: password));

        var state = context.read<SignInBloc>().state;
        if (state is SignInSuccess) {
          Authentication auth = state.authentication;
          gotoMainPage(auth);
          Navigator.pushReplacementNamed(context, MainPage.id);
        }
      }
    }

    return Scaffold(
      body: WillPopScope(
        onWillPop: () => onWillPop(context),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25.0),
                  Center(
                    child: Text(
                      'QUẢN LÝ CHI TIÊU',
                      style: kTextSize30w400White.copyWith(
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      height: 150.0,
                      width: 150.0,
                      child: Image.asset(
                        'assets/images/icon_app.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Center(
                    child: Text(
                      'ĐĂNG NHẬP',
                      style: kTextSize30w400White.copyWith(
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  BlocBuilder<SignInBloc, SignInState>(
                    builder: (context, state) {
                      switch (state.runtimeType) {
                        case SignInFailure:
                          // close loading dialog
                          Navigator.maybePop(context);
                          return ErrorMessageBox(
                              message: (state as SignInFailure).errorMessage);
                        case SignInSuccess:
                          // close loading dialog
                          Navigator.maybePop(context);
                          Authentication auth =
                              (state as SignInSuccess).authentication;
                          gotoMainPage(auth);
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
                  const Text('Mật khẩu', style: kTextSize20w400White),
                  const SizedBox(height: 10.0),
                  ReusableTextField(
                    hintText: 'Enter your Password',
                    controller: _bloc.passwordController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    suffixIcon: true,
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      const Spacer(),
                      GestureDetector(
                        onTap: () => gotoForgotPassword(),
                        child: const Text('Quên mật khẩu?',
                            style: kTextSize20w400Blue),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      Expanded(
                        child: ReusableButton(
                          onTap: () => onLogin(context),
                          buttonTitle: 'ĐĂNG NHẬP',
                          buttonColor: AppColor.red,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      BlocBuilder<SignInBloc, SignInState>(
                        builder: (context, state) {
                          var bloc = context.read<SignInBloc>();
                          return (state.fingerLogin ?? false)
                              ? GestureDetector(
                                  onTap: () =>
                                      onFingerPrinterLogin(context, bloc),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: AppColor.red,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            AppColor.red,
                                            AppColor.red.withOpacity(0.5)
                                          ],
                                        ),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                              'assets/images/fingerprinter_icon.jpg',
                                            ),
                                            fit: BoxFit.contain)),
                                  ),
                                )
                              : const SizedBox();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  const SizedBox(height: 20.0),
                  Center(
                    child: Wrap(
                      children: [
                        const Text('Chưa có tài khoản?',
                            style: kTextSize18w400White),
                        const SizedBox(width: 10.0),
                        GestureDetector(
                          onTap: () => gotoSignUp(),
                          child: const Text(
                            'Đăng ký ngay',
                            style: kTextSize18w400Red,
                          ),
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
      ),
    );
  }
}
