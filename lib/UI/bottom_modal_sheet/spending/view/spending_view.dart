import 'package:flutter/material.dart';
import 'package:spending_management/UI/bottom_modal_sheet/spending/mockdata/spending_data.dart';
import '../../widget/widget.dart';

class SpendingView extends StatelessWidget {
  const SpendingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15.0),
        const SearchBar(hintText: 'Search elements'),
        const SizedBox(height: 10.0),
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
    );
  
  }
}
