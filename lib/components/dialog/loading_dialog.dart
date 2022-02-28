import 'package:flutter/material.dart';
import 'package:spending_management/utils/app_color.dart';

import '../../utils/app_style.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Row(
        children: [
          const SizedBox(width: 30),
          SizedBox(
            height: 50.0,
            width: 50.0,
            child: Image.asset(
              'assets/images/image_placeholder.gif',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(40),
            child: Text(
              "Loading ...",
              style: kTextSize20w400White.copyWith(color: AppColor.white),
            ),
          ),
        ],
      ),
    );
  }
}
