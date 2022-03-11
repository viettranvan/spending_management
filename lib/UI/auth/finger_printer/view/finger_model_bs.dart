import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spending_management/UI/auth/finger_printer/bloc/finger_modal_bs_bloc/finger_modal_bs_bloc.dart';
import 'package:spending_management/components/components.dart';
import 'package:spending_management/utils/utils.dart';

import '../../../../services/shared_preferences.dart';

class FingerModalBS extends StatelessWidget {
  const FingerModalBS({Key? key}) : super(key: key);

  static show(BuildContext context) async {
    var result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (ctx) {
        return Padding(
          padding: MediaQuery.of(ctx).viewInsets,
          child: SizedBox(
            height: MediaQuery.of(ctx).size.height / 2 - 40,
            child: const FingerModalBS(),
          ),
        );
      },
    );
    return result;
  }

  onConfirm(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => const LoadingDialog(),
      barrierDismissible: false,
    );
    var bloc = BlocProvider.of<FingerModalBsBloc>(context);
    bloc.add(ConfirmAccount(password: bloc.passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    return BlocProvider(
      create: (context) => FingerModalBsBloc(),
      child: Column(
        children: [
          const SizedBox(height: 10.0),
          const HeaderModalBS(),
          const SizedBox(height: 10.0),
          const Center(
            child: Text(
              'Kích hoạt đăng nhập bằng vân tay cho tài khoản:',
              style: kTextSize15w400White,
            ),
          ),
          const SizedBox(height: 5.0),
          Center(
            child: Text(
              _auth.currentUser?.email ?? '',
              style: kTextSize18w400Blue.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const Spacer(),
          BlocBuilder<FingerModalBsBloc, FingerModalBsState>(
            builder: (context, state) {
              if (state is Success) {
                Future.delayed(Duration.zero).then((_) async {
                  // close laoding dialog
                  Navigator.of(context).pop();
                  await HelperSharedPreferences.saveIsFingerPrinterLogin(true);
                  await HelperSharedPreferences.saveEmail(FirebaseAuth.instance.currentUser?.email ?? '');
                  await HelperSharedPreferences.savePassword(state.password);
                  // pop to finger_printer_page
                  Navigator.of(context).pop<bool>(true);
                });
              }
              if (state is Failure) {
                // close laoding dialog
                Navigator.of(context).pop();
                return Center(
                  child: Text(
                    state.errorText,
                    style: kTextSize18w400Red,
                  ),
                );
              }
              return const SizedBox();
            },
          ),
          const Spacer(),
          const Center(
            child: Text(
              'Vui lòng nhập mật khẩu để xác thực',
              style: kTextSize15w400White,
            ),
          ),
          const SizedBox(height: 10.0),
          BlocBuilder<FingerModalBsBloc, FingerModalBsState>(
            builder: (context, state) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ReusableTextField(
                hintText: 'Enter your Password',
                controller:
                    context.read<FingerModalBsBloc>().passwordController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                obscureText: true,
                suffixIcon: true,
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          BlocBuilder<FingerModalBsBloc, FingerModalBsState>(
            builder: (context, state) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ReusableButton(
                  onTap: () => onConfirm(context),
                  buttonTitle: 'Xác thực',
                  buttonColor: AppColor.green),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
