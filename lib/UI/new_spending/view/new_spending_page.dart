import 'package:flutter/material.dart';
import 'package:spending_management/utils/utils.dart';
import 'dart:ui' as bt;

import '../widgets/search_bar.dart';

class NewSpendingPage extends StatelessWidget {
  static const String id = 'new_speding';
  const NewSpendingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moneyController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.background,
        leading: Image.asset(
          'assets/images/back_icon.jpg',
          color: Colors.white,
        ),
        title: const Text(
          'Thêm mới',
          style: kTextSize25w400White,
        ),
        elevation: 2.0,
        shadowColor: Colors.white,
      ),
      backgroundColor: AppColor.black,
      body: Column(
        children: [
          const SizedBox(
            height: 10.0,
          ),
          TextField(
            controller: moneyController,
            style: kTextSize40BoldWhite,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              filled: true,
              fillColor: AppColor.grey,
              hintText: '0.0',
              hintStyle: kTextSize40BoldWhite,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(
                    10.0,
                  ),
                ),
              ),
            ),
          ),
          Text(
            '${moneyController.text} VND',
            style: kTextSize30w400White,
          ),
          TextButton(
            onPressed: () => _openNewLookBook(context),
            child: Text('Model Sheet'),
          )
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
                  kToolbarHeight) - 100,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  const SizedBox(
                      width: 50.0,
                      child: Divider(
                        color: AppColor.grey,
                        thickness: 5.0,
                      )),
                  const SizedBox(height: 16),
                  const SearchBar(hintText: 'Search Elements'),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => {Navigator.pop(context)},
                        child: const Icon(Icons.close),
                      ),
                      const Text(
                        'ELEMENTS',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          letterSpacing: 2,
                          color: AppColor.background,
                        ),
                      ),
                      Container()
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Expanded(
                    child: ListView(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      children: const [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'RECENTLY USED',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                letterSpacing: 2,
                                color: AppColor.background),
                          ),
                        ),
                        SizedBox(height: 16),
                        SizedBox(
                          height: 16.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // _onChangePage(state),
            ),
          ),
        );
      },
    );
  }
}
