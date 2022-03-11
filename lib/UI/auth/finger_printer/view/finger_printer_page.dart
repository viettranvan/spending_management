import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spending_management/UI/auth/finger_printer/bloc/finger_printer_bloc.dart';
import 'package:spending_management/UI/auth/finger_printer/view/finger_model_bs.dart';
import 'package:spending_management/components/dialog/custom_dialog.dart';
import 'package:spending_management/utils/app_style.dart';

class FingerPrinterPage extends StatelessWidget {
  static const String id = 'finger_printer';
  const FingerPrinterPage({Key? key}) : super(key: key);

  _openEnableFinger(BuildContext context, FingerPrinterBloc bloc) async {
    bool? data = await FingerModalBS.show(context);
    if (data != null && data) {
      bloc.add(EnableFinger());
    }
  }

  _openDisableFinger(BuildContext context, FingerPrinterBloc bloc) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CustomDialog(
        title: 'Thông báo',
        content: 'Bạn có muốn hủy phương thức đăng nhập bằng vân tay',
        onSubmit: (){
          bloc.add(DisableFinger());
          // close diglog
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Đăng nhập bằng vân tay',
          style: kTextSize25w400White.copyWith(fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Image.asset(
            'assets/images/icon_back.png',
            color: Colors.white,
          ),
        ),
        elevation: 2.0,
        shadowColor: Colors.white,
      ),
      body: BlocProvider(
        create: (context) => FingerPrinterBloc()..add(FetchData()),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 10.0,
                ),
                const Text(
                  'Đăng nhập bằng vân tay',
                  style: kTextSize18w400White,
                ),
                const Spacer(),
                BlocBuilder<FingerPrinterBloc, FingerPrinterState>(
                  builder: (context, state) {
                    var bloc = context.read<FingerPrinterBloc>();
                    return Center(
                      child: Switch(
                        value: (state as FingerPrinterInitial).enable ?? false,
                        onChanged: (value) {
                          if (value) {
                            _openEnableFinger(context, bloc);
                          } else {
                            _openDisableFinger(context, bloc);
                          }
                        },
                        activeTrackColor: Colors.lightGreenAccent,
                        activeColor: Colors.green,
                      ),
                    );
                  },
                ),
                const SizedBox(
                  width: 10.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
