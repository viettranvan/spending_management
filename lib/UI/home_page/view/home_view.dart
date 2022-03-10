import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spending_management/UI/edit_spending/view/edit_spending_page.dart';
import 'package:spending_management/UI/home_page/bloc/home_bloc.dart';
import 'package:spending_management/utils/utils.dart';

import '../widgets/widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  Widget itemBuilder(BuildContext context, int index) {
    var state = context.read<HomeBloc>().state;

    if (state is HomeLoaded) {
      return HomeSpendingItem(
        date: state.lists[index].date,
        preDate: index > 0 ? state.lists[index - 1].date : '',
        iconPath: state.lists[index].iconPath,
        money: state.lists[index].money,
        note: state.lists[index].note,
        type: state.lists[index].type,
        typeItem: state.lists[index].typeItem,
        onTap: () {
          Navigator.of(context).pushNamed(
            EditSpendingPage.id,
            arguments: {'itemId': state.lists[index].id},
          );
        },
      );
    }
    return const SizedBox();
  }

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
                      balance: getBalance(state.totalEarn, state.totalSpent),
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
                  itemBuilder: itemBuilder,
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
