import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spending_management/models/spending_model.dart';
import 'package:spending_management/utils/utils.dart';

import '../../../components/components.dart';
import '../../bottom_modal_sheet/type_modal_bs.dart/view/type_modal_bs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../main_page/view/main_page.dart';
import '../bloc/edit_spending_bloc.dart';
import 'package:marquee/marquee.dart';

// ignore: must_be_immutable
class EditSpendingView extends StatelessWidget {
  EditSpendingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<EditSpendingBloc>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.background,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Image.asset(
            'assets/images/icon_back.png',
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Chỉnh sửa',
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
            BlocBuilder<EditSpendingBloc, EditSpendingState>(
              builder: (context, state) {
                if (state is DataLoaded) {
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
                        _moneyTextField(context, bloc),
                        _moneyValue(state),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          decoration: const BoxDecoration(
                              color: AppColor.grey,
                              border: Border(
                                top:
                                    BorderSide(width: 1.5, color: Colors.white),
                              )),
                          child: Column(
                            children: [
                              _type(context, bloc),
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
                            children: [
                              const Spacer(),
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () => onEdit(context, bloc),
                                    child: Container(
                                      height: 60.0,
                                      width: 60.0,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(60.0),
                                          color: Colors.white,
                                          image: const DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/edit_icon.png'),
                                              fit: BoxFit.fill)),
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  const Text(
                                    'Cập nhật',
                                    style: kTextSize15w400White,
                                  ),
                                ],
                              ),
                              const SizedBox(width: 20.0),
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () => onDelete(context, bloc),
                                    child: Container(
                                      height: 60.0,
                                      width: 60.0,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(60.0),
                                          color: Colors.white,
                                          image: const DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/delete_icon.png'),
                                              fit: BoxFit.fill)),
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  const Text(
                                    'Xóa',
                                    style: kTextSize15w400White,
                                  ),
                                ],
                              ),
                              const SizedBox(width: 25.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _moneyTextField(BuildContext context, EditSpendingBloc bloc) {
    return Row(
      children: [
        BlocBuilder<EditSpendingBloc, EditSpendingState>(
          builder: (context, state) => Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                  onTap: () => _openSpendingType(context, bloc),
                  child: Container(
                    height: 50.0,
                    width: 50.0,
                    margin: const EdgeInsets.only(left: 10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60.0),
                        color: Colors.white,
                        image: DecorationImage(
                            image: (state as DataLoaded).spendingType == null
                                ? AssetImage(state.homeSpending?.iconPath ??
                                    'assets/images/another_icon.png')
                                : AssetImage(state.spendingType?.iconPath ??
                                    'assets/images/another_icon.png'),
                            fit: BoxFit.fill)),
                  )),
              const SizedBox(
                width: 5.0,
              ),
              state.spendingType == null
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(state.homeSpending?.typeItem ?? ''),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(state.spendingType?.title ?? ''),
                    ),
            ],
          ),
        ),
        Expanded(
          child: TextField(
            controller: bloc.moneyController,
            style: kTextSize40BoldWhite,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              bloc.add(MoneyChange(money: value));
            },
            textAlign: TextAlign.end,
            decoration: const InputDecoration(
              filled: true,
              fillColor: AppColor.background,
              hintText: '0.0',
              hintStyle: kTextSize40BoldWhite,
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _moneyValue(EditSpendingState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Visibility(
        visible: (state as DataLoaded).money?.isNotEmpty ?? true,
        child: Text(
          formatMoney(
              state.money ?? (state.homeSpending?.money.toString() ?? '')),
          style: kTextSize20w400White,
        ),
      ),
    );
  }

  Widget _type(BuildContext context, EditSpendingBloc bloc) {
    return InkWell(
      onTap: () => _openSpendingType(context, bloc),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            const CircleAvatar(
                radius: 15.0,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('assets/images/type_icon.jpg')),
            const SizedBox(
              width: 15.0,
            ),
            const Text(
              'Loại',
              style: kTextSize18w400White,
            ),
            const SizedBox(
              width: 15.0,
            ),
            BlocBuilder<EditSpendingBloc, EditSpendingState>(
              builder: (context, state) =>
                  (state as DataLoaded).spendingType == null
                      ? Text(
                          state.homeSpending?.typeItem ?? '',
                          style: kTextSize18w400White,
                        )
                      : Text(
                          state.spendingType!.title ?? '',
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
        context
            .read<EditSpendingBloc>()
            .add(PickDate(date: date ?? DateTime.now()));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            const CircleAvatar(
                radius: 15.0,
                backgroundColor: Colors.amber,
                backgroundImage: AssetImage('assets/images/datetime_icon.jpg')

                // NetworkImage(
                //     'https://toigingiuvedep.vn/wp-content/uploads/2021/06/hinh-anh-anime-girl-deo-kinh-thoi-trang-tri-thuc-dep-nhat.jpg'),
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
            BlocBuilder<EditSpendingBloc, EditSpendingState>(
                builder: (context, state) {
              DateTime now = DateTime.now();
              var dState = (state as DataLoaded).homeSpending?.date;
              int year =
                  int.parse(dState?.substring(0, 4) ?? now.year.toString());
              int month =
                  int.parse(dState?.substring(5, 7) ?? now.year.toString());
              int day =
                  int.parse(dState?.substring(8, 10) ?? now.year.toString());

              DateTime dt = DateTime(year, month, day);
              return Expanded(
                child: Text(
                  getDateString(
                    state.chooseDay ?? dt,
                  ),
                  style: kTextSize18w400White,
                ),
              );
            }),
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

  Widget _note(EditSpendingBloc bloc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          const CircleAvatar(
              radius: 15.0,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/images/note_icon.png')),
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

  _openSpendingType(BuildContext context, EditSpendingBloc bloc) async {
    SpendingModel? model = await TypeModalBS.show(context);
    bloc.add(PickSpendingType(spendingModel: model));
  }

  onEdit(BuildContext context, EditSpendingBloc bloc) {
    var _auth = FirebaseAuth.instance;

    var spending = FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .collection('spending');
    var state = bloc.state;
    if (state is DataLoaded) {
      DateTime now = DateTime.now();
      var dState = state.homeSpending?.date;
      int year = int.parse(dState?.substring(0, 4) ?? now.year.toString());
      int month = int.parse(dState?.substring(5, 7) ?? now.year.toString());
      int day = int.parse(dState?.substring(8, 10) ?? now.year.toString());
      DateTime dt = DateTime(year, month, day);

      String moneyString = bloc.moneyController.text.isEmpty
          ? state.homeSpending?.money.toString() ?? '0'
          : bloc.moneyController.text;
      String validateMoney = moneyString.replaceAll(RegExp(r"\D"), "");

      int money = int.parse(validateMoney.isEmpty ? '0' : validateMoney);

      String? title = state.spendingType == null
          ? state.homeSpending?.typeItem
          : state.spendingType!.title;
      String? type = state.spendingType == null
          ? state.homeSpending?.type
          : state.spendingType!.spendingType;
      DateTime date = state.chooseDay ?? dt;
      String note = bloc.noteController.text;
      String iconPath = state.spendingType == null
          ? (state.homeSpending?.iconPath ?? 'assets/image/another_icon.png')
          : state.spendingType?.iconPath ?? 'assets/image/another_icon.png';
      String itemId = state.homeSpending!.id;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => CustomDialog(
          title: 'Thông báo',
          content: 'Bạn có muốn cập nhật?',
          onSubmit: () async {
            await spending.doc(itemId).update({
              'date': DateTime(date.year, date.month, date.day, now.hour,
                  now.minute, now.second, now.microsecond),
              'note': note,
              'type': type,
              'type_item': title,
              'money': money,
              'icon_path': iconPath,
            });
            // close dialog
            Navigator.pop(context);
            // navigate to main page
            Navigator.pushNamedAndRemoveUntil(
                context, MainPage.id, (route) => false);

            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Dữ liệu của bạn đã được cập nhật!')));
          },
        ),
      );
    }
  }

  onDelete(BuildContext context, EditSpendingBloc bloc) async {
    var _auth = FirebaseAuth.instance;

    var spending = FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .collection('spending');
    var state = bloc.state;
    if (state is DataLoaded) {
      var itemId = state.homeSpending!.id;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => CustomDialog(
          title: 'Thông báo',
          content: 'Bạn có muốn xóa không?',
          onSubmit: () async {
            await spending.doc(itemId).delete();
            // close dialog
            Navigator.pop(context);
            // navigate to main page
            Navigator.pushNamedAndRemoveUntil(
                context, MainPage.id, (route) => false);

            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Dữ liệu của bạn đã được cập nhật!')));
          },
        ),
      );
      
    }
  }
}
