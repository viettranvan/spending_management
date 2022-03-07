import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spending_management/UI/main_page/view/main_page.dart';
import 'package:spending_management/components/dialog/loading_dialog.dart';
import 'package:spending_management/models/spending_model.dart';
import 'package:spending_management/utils/utils.dart';

import '../../bottom_modal_sheet/type_modal_bs.dart/view/type_modal_bs.dart';
import '../bloc/new_spending_bloc.dart';
import '../widgets/divider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
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
                      _moneyTextField(context, bloc),
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
                            GestureDetector(
                              onTap: () => onSave(context, bloc),
                              child: const CircleAvatar(
                                  radius: 30.0,
                                  child: Icon(
                                    Icons.save,
                                    size: 40.0,
                                  )),
                            ),
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

  Widget _moneyTextField(BuildContext context, NewSpendingBloc bloc) {
    return Row(
      children: [
        BlocBuilder<NewSpendingBloc, NewSpendingState>(
          builder: (context, state) => Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => _openSpendingType(context, bloc),
                child: const CircleAvatar(
                  radius: 30.0,
                  child: Icon(
                    Icons.save,
                    size: 40.0,
                  ),
                ),
              ),
              const SizedBox(
                width: 5.0,
              ),
              (state as NewSpendingInitial).spendingType == null
                  ? const Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(''),
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

  Widget _type(BuildContext context, NewSpendingBloc bloc) {
    return InkWell(
      onTap: () => _openSpendingType(context, bloc),
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
              'Loại',
              style: kTextSize18w400White,
            ),
            const SizedBox(
              width: 15.0,
            ),
            BlocBuilder<NewSpendingBloc, NewSpendingState>(
              builder: (context, state) =>
                  (state as NewSpendingInitial).spendingType == null
                      ? const Text(
                          'Chọn mục',
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

        // var dateString = getDateString(date ?? DateTime.now());
        context
            .read<NewSpendingBloc>()
            .add(PickDate(date: date ?? DateTime.now()));
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
                getDateString(
                  (state as NewSpendingInitial).chooseDay ?? DateTime.now(),
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

  _openSpendingType(BuildContext context, NewSpendingBloc bloc) async {
    SpendingModel? model = await TypeModalBS.show(context);
    bloc.add(PickSpendingType(spendingModel: model));
  }

  onSave(BuildContext context, NewSpendingBloc bloc) async {
    CollectionReference spending =
        FirebaseFirestore.instance.collection('spending');

    var state = bloc.state;
    if (state is NewSpendingInitial) {
      String moneyString =
          bloc.moneyController.text.isEmpty ? '0' : bloc.moneyController.text;
      String validateMoney = moneyString.replaceAll(RegExp(r"\D"), "");

      int money = int.parse(validateMoney.isEmpty ? '0' : validateMoney);

      String? title =
          state.spendingType == null ? null : state.spendingType!.title;
      String? type =
          state.spendingType == null ? null : state.spendingType!.spendingType;  
      DateTime date = state.chooseDay ?? DateTime.now();
      String note = bloc.noteController.text;

      if (money <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nhập số tiền!')),
        );
      } else if (title == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Chọn loại!')),
        );
      } else {
        var now = DateTime.now();
        var data = {
          'date': DateTime(date.year, date.month, date.day, now.hour,
              now.minute, now.second, now.microsecond),
          'money': money,
          'note': note,
          'type': type,
          'type_item': title
        };
        showDialog(context: context, builder: (context) => const LoadingDialog(),barrierDismissible: false);
        await spending.add(data);
        // close dialog
        Navigator.pop(context);
        // navigate to main page
        Navigator.pushNamedAndRemoveUntil(context, MainPage.id, (route) => false);
      }
    }

    // var value = await spending.get();
    // var list = value.docs;

    // print('list: ${list.length}');
    // print('item: ${list.first.data()}');

    // FirebaseFirestore.instance
    //     .collection('spending')
    //     .orderBy('date', descending: true)
    //     .get()
    //     .then((QuerySnapshot querySnapshot) {
    //   for (var doc in querySnapshot.docs) {
    //     print(
    //         'data: ${DateTime.parse(doc['date'].toDate().toString())} ---- ${doc['money']}');
    //     // print('viet: ${doc['money']}');
    //   }
    // });

    // for(var item in list){
    //   print('item: ${item.data()}')
    // }
    // .then((value) {
    //   print('abc: ${value.docs.length}');
    // });
  }
}
