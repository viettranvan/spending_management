import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class HeaderModalBS extends StatelessWidget {
  const HeaderModalBS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 50.0,
      child: Divider(
        color: AppColor.grey,
        thickness: 5.0,
      ),
    );
  }
}
