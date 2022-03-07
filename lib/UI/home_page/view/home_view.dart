import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spending_management/UI/home_page/bloc/home_bloc.dart';
import 'package:spending_management/UI/home_page/widgets/flexiable_app_bar.dart';
import 'package:spending_management/UI/profile_page/bloc/profile_bloc.dart';
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
            title: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) => TitleAppBar(
                name: currentuser == null
                    ? 'User'
                    : currentuser.displayName ?? 'User',
                imgPath: currentuser == null
                    ? noProfileImage
                    : currentuser.photoURL ?? noProfileImage,
              ),
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
                        return HomeSpendingItem(
                          date: state.lists[index].date,
                          preDate: index > 0 ? state.lists[index - 1].date : '',
                          iconPath: '',
                          money: state.lists[index].money,
                          note: state.lists[index].note,
                          type: state.lists[index].type,
                          typeItem: state.lists[index].typeItem,
                        );
                      },
                      childCount: state.lists.length,
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

class HomeSpendingItem extends StatelessWidget {
  const HomeSpendingItem({
    Key? key,
    required this.typeItem,
    required this.type,
    required this.note,
    required this.date,
    required this.iconPath,
    required this.money,
    required this.preDate,
  }) : super(key: key);

  final String typeItem;
  final String note;
  final String iconPath;
  final int money;
  final String type;
  final String date;
  final String preDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: date != preDate,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(date, style: kTextSize20w400White),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: ListTile(
                leading: const CircleAvatar(
                  radius: 30.0,
                  child: FlutterLogo(
                    size: 30.0,
                  ),
                ),
                title: Text(typeItem, style: kTextSize18w400White),
                subtitle: Text(note.isEmpty ? 'Không có ghi chú' : note,
                    style: kTextSize15w400White),
                isThreeLine: true,
              ),
            ),
            Row(
              children: [
                Text(type == 'spending' ? '-' : '+',
                    style: type == 'spending'
                        ? kTextSize18w400Red
                        : kTextSize18w400Green),
                Text(formatMoney(money.toString()),
                    style: type == 'spending'
                        ? kTextSize18w400Red
                        : kTextSize18w400Green),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
