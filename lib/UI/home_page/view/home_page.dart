import 'package:flutter/material.dart';
import 'package:spending_management/UI/home_page/widgets/flexiable_app_bar.dart';
import 'package:spending_management/utils/app_color.dart';

import '../widgets/title_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: TitleAppBar(),
            pinned: true,
            floating: true,
            expandedHeight: 230.0,
            backgroundColor: AppColor.background,
            flexibleSpace: FlexibleSpaceBar(
              background: MyFlexiableAppBar(),
            ),
          ),

          SliverToBoxAdapter(
            child: Center(
              child: Stack(
                children: [
                  Image.network(
                      'https://p4.wallpaperbetter.com/wallpaper/94/600/32/anime-anime-girls-digital-art-artwork-portrait-display-hd-wallpaper-preview.jpg'),
                  Positioned(
                    top: -10,
                    left: -20,
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.asset('assets/images/bubble_chat.png'),
                    ),
                  ),
                  const Positioned(
                    top: 50.0,
                    left: 50.0,
                    child: Text(
                      'Chưa có\ndữ liệu!',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // SliverList(
          //   delegate: SliverChildBuilderDelegate(
          //     (_, int index) {
          //       return ListTile(
          //         leading: Container(
          //             padding: EdgeInsets.all(8),
          //             width: 100,
          //             child: Placeholder()),
          //         title: Text('Place ${index + 1}', textScaleFactor: 2),
          //       );
          //     },
          //     childCount: 20,
          //   ),
          // ),
        ],
      ),
    );
  }
}
