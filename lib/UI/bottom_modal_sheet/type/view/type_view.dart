import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/utils.dart';
import '../../earnings/view/earning_view.dart';
import '../../spending/view/spending_view.dart';
import '../../widget/search_bar.dart';
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
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
            color: AppColor.background,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: BlocBuilder<TypeBloc, TypeState>(
            builder: (context, state) => Column(
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
                  children: [
                    Column(
                      children:  [
                        const SizedBox(height: 15.0),
                        const SearchBar(hintText: 'Search elements'),
                        const SizedBox(height: 10.0),
                        Expanded(child: Text('abc')),
                        // SizedBox(
                        //   height: 300.0,
                        //   child: GridView.builder(
                        //     padding: const EdgeInsets.all(16.0),
                        //     itemCount: listSpending.length,
                        //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        //       crossAxisCount: 2,
                        //       crossAxisSpacing: 8,
                        //       mainAxisSpacing: 8,
                        //       childAspectRatio: 6/2,
                        //     ),
                        //     itemBuilder: (context, index) {
                        //       return TypeItem(
                        //         iconPath:
                        //             'https://i.pinimg.com/736x/ee/6d/68/ee6d688425e2467819427e4ccbc90ca9.jpg',
                        //         title: listSpending[index].title ?? '',
                        //       );
                        //     },
                        //   ),
                        // ),
                        // Expanded(
                        //   child: Container(
                        //     color: Colors.amber,
                        //     child: Text('abc'),
                        //   ),
                        // ),
                      ],
                    ),
      
                    // SpendingView(),
                    const EarningsView(),
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
      ),
    );
 
  }
}
