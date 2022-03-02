import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/utils.dart';
import '../../earnings/view/earning_view.dart';
import '../../spending/view/spending_view.dart';
import '../bloc/type_bloc.dart';


class TypeView extends StatelessWidget {
  const TypeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Tab> tabs = const <Tab>[
      Tab(text: 'Chi tiêu'),
      Tab(text: 'Thu nhập'),
    ];
    return BlocProvider(
      create: (context) => TypeBloc(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(
          color: AppColor.background,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: BlocBuilder<TypeBloc,TypeState>(
          builder: (context, state) =>  Column(
            children: [
              const SizedBox(height: 12),
              const SizedBox(
                width: 50.0,
                child: Divider(
                  color: AppColor.grey,
                  thickness: 5.0,
                ),
              ),
              DefaultTabController(
                length: tabs.length,
                child: TabBar(
                  tabs: tabs,
                  labelColor: AppColor.iconColorStart,
                  unselectedLabelColor: AppColor.white,
                  indicatorColor: AppColor.iconColorStart,
                  labelStyle: kTextSize15w400White,
                  indicator: const UnderlineTabIndicator(
                    borderSide: BorderSide(color: AppColor.iconColorStart),
                  ),
                  onTap: (int index) {
                    context.read<TypeBloc>().add(ChangeTab(index: index));
                  },
                ),
              ),
              IndexedStack(
                index: state.index,
                children: const [
                  SpendingView(),
                  EarningsView(),
                ],
              ),
            
              // const Expanded(
              //   child: TabBarView(
              //     children: [
              //       Text('1'),
              //       Text('2'),
              //     ],
              //   ),
              // )
            
              //    SearchBar(hintText: 'Search Elements'),
              //  SizedBox(
              //     height: 16.0,
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
