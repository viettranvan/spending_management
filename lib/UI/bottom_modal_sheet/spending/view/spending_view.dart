import 'package:flutter/material.dart';
import 'package:spending_management/UI/bottom_modal_sheet/widget/search_bar.dart';

class SpendingView extends StatelessWidget {
  const SpendingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(height: 15.0,),
        SearchBar(hintText: 'Search elements'),
        Center(
          child: Text('search'),
        ),
      ],
    );
  }
}
