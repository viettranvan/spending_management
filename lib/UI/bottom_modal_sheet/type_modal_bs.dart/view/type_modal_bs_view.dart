import 'package:flutter/material.dart';
import 'package:spending_management/UI/bottom_modal_sheet/earnings/view/earning_view.dart';

import '../../../../utils/utils.dart';
import '../../spending/view/spending_page.dart';
import '../../widget/widget.dart';

class TypeModalBSView extends StatefulWidget {
  const TypeModalBSView({
    Key? key,
  }) : super(key: key);

  @override
  State<TypeModalBSView> createState() => _TypeModalBSViewState();
}

class _TypeModalBSViewState extends State<TypeModalBSView>
    with SingleTickerProviderStateMixin {
  List<Tab> tabs = const <Tab>[
    Tab(text: 'Chi tiêu'),
    Tab(text: 'Thu nhập'),
  ];
  // ignore: prefer_typing_uninitialized_variables
  late final controller;
  @override
  void initState() {
    controller = TabController(length: tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 12),
                const HeaderModalBS(),
                DefaultTabController(
                  length: tabs.length,
                  child: TabBar(
                    controller: controller,
                    tabs: tabs,
                    labelColor: AppColor.iconColorStart,
                    unselectedLabelColor: AppColor.white,
                    indicatorColor: AppColor.iconColorStart,
                    labelStyle: kTextSize15w400White,
                    indicator: const UnderlineTabIndicator(
                      borderSide: BorderSide(color: AppColor.iconColorStart),
                    ),
                    onTap: (int index) {
                      // context.read<TypeBloc>().add(ChangeTab(index: index));
                    },
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: controller,
                    children: const [
                      SpendingPage(),
                      EarningsView()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
