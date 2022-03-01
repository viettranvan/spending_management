import 'package:flutter/material.dart';

class TitleAppBar extends StatelessWidget {

  const TitleAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const <Widget>[
        CircleAvatar(
          radius: 25.0,
          child: FlutterLogo(size: 30.0),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Name Here',
            style: TextStyle(
                color: Colors.white,  fontSize: 20.0),
          ),
        ),
        SizedBox(width: 50.0,),
      ],
    );
  }
}
