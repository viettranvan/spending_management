import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spending_management/UI/home_page/bloc/home_bloc.dart';
import 'package:spending_management/UI/home_page/widgets/flexiable_app_bar.dart';
import 'package:spending_management/utils/utils.dart';

import '../widgets/title_app_bar.dart';
import '../widgets/widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentuser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxScrolled) => [
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
            expandedHeight: 250.0,
            backgroundColor: AppColor.background,
            flexibleSpace: FlexibleSpaceBar(
              background: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoaded) {
                    return MyFlexiableAppBar(
                      totalSpent: formatMoney(state.totalSpent.toString()),
                      totalEarn: formatMoney(state.totalEarn.toString()),
                      balance: formatMoney(
                          (state.totalEarn - state.totalSpent).toString()),
                      endDate:
                          state.lists.isEmpty ? '' : state.lists.first.date,
                      startDate:
                          state.lists.isEmpty ? '' : state.lists.last.date,
                    );
                  }
                  return MyFlexiableAppBar(
                    totalSpent: formatMoney('0'),
                    totalEarn: formatMoney('0'),
                    balance: formatMoney('0'),
                    endDate: '',
                    startDate: '',
                  );
                },
              ),
            ),
          ),
        ],
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoaded) {
              if (state.lists.isNotEmpty) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return HomeSpendingItem(
                      date: state.lists[index].date,
                      preDate: index > 0 ? state.lists[index - 1].date : '',
                      iconPath: state.lists[index].iconPath,
                      money: state.lists[index].money,
                      note: state.lists[index].note,
                      type: state.lists[index].type,
                      typeItem: state.lists[index].typeItem,
                    );
                  },
                  itemCount: state.lists.length,
                );
              } else {
                return const NoData();
              }
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

