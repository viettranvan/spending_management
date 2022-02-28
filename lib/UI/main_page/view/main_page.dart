import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  static const String id = 'main_page';
  const MainPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          Text("hello world"),
        ],
      ),
    );
  }
}