import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spending_management/UI/bottom_modal_sheet/spending/bloc/spending_bloc.dart';
import 'package:spending_management/utils/utils.dart';
import 'dart:ui' as bt;

import '../../bottom_modal_sheet/type/view/type_view.dart';
import '../bloc/new_spending_bloc.dart';
import '../widgets/divider.dart';

class NewSpendingView extends StatelessWidget {
  const NewSpendingView({Key? key}) : super(key: key);

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
            child: const TypeView());
      },
    );
  }
}
