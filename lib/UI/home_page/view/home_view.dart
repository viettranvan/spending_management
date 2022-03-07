import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spending_management/UI/home_page/bloc/home_bloc.dart';
import 'package:spending_management/UI/home_page/widgets/flexiable_app_bar.dart';
import 'package:spending_management/utils/utils.dart';

import '../widgets/title_app_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentuser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: TitleAppBar(
              name: currentuser == null
                  ? 'User'
                  : currentuser.displayName ?? 'User',
              imgPath: currentuser == null
                  ? noProfileImage
                  : currentuser.photoURL ?? noProfileImage,
            ),
            pinned: true,
            floating: true,
            expandedHeight: 230.0,
            backgroundColor: AppColor.background,
            flexibleSpace: const FlexibleSpaceBar(
              background: MyFlexiableAppBar(),
            ),
          ),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoaded) {
                if (state.lists.isEmpty) {
                  return SliverToBoxAdapter(
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
                              child:
                                  Image.asset('assets/images/bubble_chat.png'),
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
                  );
                } else {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, int index) {
                        return ListTile(
                          leading: Container(
                              padding: EdgeInsets.all(8),
                              width: 100,
                              child: Placeholder()),
                          title: Text('Place ${index + 1}', textScaleFactor: 2),
                        );
                      },
                      childCount: 20,
                    ),
                  );
                }
              }
              return const SliverToBoxAdapter(
                child: SizedBox(),
              );
            },
          ),
        ],
      ),
    );
  }
}
