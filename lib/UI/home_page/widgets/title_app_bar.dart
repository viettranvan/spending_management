import 'package:flutter/material.dart';

class TitleAppBar extends StatelessWidget {
  const TitleAppBar({Key? key, required this.name, required this.imgPath})
      : super(key: key);
  final String name;
  final String imgPath;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CircleAvatar(
          radius: 25.0,
          backgroundImage:
          NetworkImage(
            imgPath,
          ),
          
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            name,
            style: const TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
        const SizedBox(
          width: 50.0,
        ),
      ],
    );
  }
}
