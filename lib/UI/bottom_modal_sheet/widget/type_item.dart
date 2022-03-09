import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class TypeItem extends StatelessWidget {
  const TypeItem({
    Key? key,
    required this.title,
    required this.iconPath,
  }) : super(key: key);
  final String title;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CircleAvatar(
          radius: 20.0,
          backgroundColor: Colors.white,
          backgroundImage: AssetImage(iconPath),
        ),
        const SizedBox(
          width: 10.0,
        ),
        Text(title, style: kTextSize20w400White),
      ],
    );
  }
}
