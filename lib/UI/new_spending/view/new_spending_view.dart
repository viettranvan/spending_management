import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spending_management/UI/bottom_modal_sheet/spending/bloc/spending_bloc.dart';
import 'package:spending_management/utils/utils.dart';
import 'dart:ui' as bt;

import '../../bottom_modal_sheet/type/bloc/type_bloc.dart';
import '../../bottom_modal_sheet/type/view/type_view.dart';
import '../../bottom_modal_sheet/widget/search_bar.dart';
import '../bloc/new_spending_bloc.dart';
import '../widgets/divider.dart';

class NewSpendingView extends StatelessWidget {
  NewSpendingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<NewSpendingBloc>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.background,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Image.asset(
            'assets/images/back_icon.jpg',
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Thêm mới',
          style: kTextSize25w400White,
        ),
        elevation: 2.0,
        shadowColor: Colors.white,
      ),
      backgroundColor: AppColor.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30.0,
            ),
            BlocBuilder<NewSpendingBloc, NewSpendingState>(
              builder: (context, state) {
                return Container(
                  padding: const EdgeInsets.only(top: 30.0),
                  decoration: BoxDecoration(
                    color: AppColor.background,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _moneyTextField(bloc),
                      _moneyValue(state),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: const BoxDecoration(
                            color: AppColor.grey,
                            border: Border(
                              top: BorderSide(width: 1.5, color: Colors.white),
                            )),
                        child: Column(
                          children: [
                            _type(context),
                            const CustomDivider(),
                            _time(context),
                            const CustomDivider(),
                            _note(bloc),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Row(
                          children: const [
                            Spacer(),
                            CircleAvatar(
                                radius: 30.0,
                                child: Icon(
                                  Icons.save,
                                  size: 40.0,
                                )),
                            SizedBox(width: 25.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _moneyTextField(NewSpendingBloc bloc) {
    return TextField(
      controller: bloc.moneyController,
      style: kTextSize40BoldWhite,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        bloc.add(MoneyChange(money: value));
      },
      decoration: const InputDecoration(
          filled: true,
          fillColor: AppColor.background,
          hintText: '0.0',
          hintStyle: kTextSize40BoldWhite,
          border: InputBorder.none),
    );
  }

  Widget _moneyValue(NewSpendingState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Visibility(
        visible: (state as NewSpendingInitial).money.isNotEmpty,
        child: Text(
          formatMoney(state.money),
          style: kTextSize20w400White,
        ),
      ),
    );
  }

  Widget _type(BuildContext context) {
    return InkWell(
      onTap: () => _openNewLookBook(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: const [
            CircleAvatar(
              radius: 15.0,
              backgroundColor: Colors.amber,
              backgroundImage: NetworkImage(
                  'https://toigingiuvedep.vn/wp-content/uploads/2021/06/hinh-anh-anime-girl-deo-kinh-thoi-trang-tri-thuc-dep-nhat.jpg'),
            ),
            SizedBox(
              width: 15.0,
            ),
            Text(
              'Loại',
              style: kTextSize18w400White,
            ),
            SizedBox(
              width: 15.0,
            ),
            Text(
              'Chọn mục',
              style: kTextSize18w400White,
            ),
            Spacer(),
            Icon(
              Icons.arrow_right,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  Widget _time(BuildContext context) {
    return InkWell(
      onTap: () async {
        var date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );

        var dateString = getDateString(date ?? DateTime.now());
        context.read<NewSpendingBloc>().add(PickDate(date: dateString));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 15.0,
              backgroundColor: Colors.amber,
              backgroundImage: NetworkImage(
                  'https://toigingiuvedep.vn/wp-content/uploads/2021/06/hinh-anh-anime-girl-deo-kinh-thoi-trang-tri-thuc-dep-nhat.jpg'),
            ),
            const SizedBox(
              width: 15.0,
            ),
            const Text(
              'Thời gian',
              style: kTextSize18w400White,
            ),
            const SizedBox(
              width: 15.0,
            ),
            BlocBuilder<NewSpendingBloc, NewSpendingState>(
              builder: (context, state) => Text(
                (state as NewSpendingInitial).chooseDay ??
                    getDateString(
                      DateTime.now(),
                    ),
                style: kTextSize18w400White,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_right,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  Widget _note(NewSpendingBloc bloc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 15.0,
            backgroundColor: Colors.amber,
            backgroundImage: NetworkImage(
                'https://toigingiuvedep.vn/wp-content/uploads/2021/06/hinh-anh-anime-girl-deo-kinh-thoi-trang-tri-thuc-dep-nhat.jpg'),
          ),
          const SizedBox(
            width: 15.0,
          ),
          const Text(
            'Ghi chú',
            style: kTextSize18w400White,
          ),
          const SizedBox(
            width: 15.0,
          ),
          Expanded(
            child: TextField(
              controller: bloc.noteController,
              decoration: const InputDecoration(
                  hintText: 'Thêm ghi chú', border: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }

  List<Tab> tabs = const <Tab>[
    Tab(text: 'Chi tiêu'),
    Tab(text: 'Thu nhập'),
  ];
  _openNewLookBook(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height -
              (MediaQueryData.fromWindow(bt.window).padding.top +
                  kToolbarHeight) -
              100,
          child:BlocProvider(
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
                                borderSide:
                                    BorderSide(color: AppColor.iconColorStart),
                              ),
                              onTap: (int index) {
                                context
                                    .read<TypeBloc>()
                                    .add(ChangeTab(index: index));
                              },
                            ),
                          ),
                          IndexedStack(
                            index: state.index,
                            children: [
                              Column(
                                children: [
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
                              const Text('abc'),
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
              ),
            

          // const TypeView()
        );
      },
    );
  }
}
