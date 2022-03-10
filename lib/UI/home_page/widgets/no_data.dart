import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  const NoData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Stack(children: [
          Image.network(
            'https://p4.wallpaperbetter.com/wallpaper/94/600/32/anime-anime-girls-digital-art-artwork-portrait-display-hd-wallpaper-preview.jpg',
            fit: BoxFit.fill,
          ),
          Positioned(
            top: 20,
            left: -20,
            child: SizedBox(
              height: 200,
              width: 200,
              child: Image.asset('assets/images/bubble_chat.png'),
            ),
          ),
          const Positioned(
            top: 80.0,
            left: 50.0,
            child: Text(
              'Chưa có\ndữ liệu!',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ]),
      ),
    );
  }
}
