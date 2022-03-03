import 'package:flutter/material.dart';

import '../../widget/widget.dart';
import '../mockdata/earning_data.dart';

class EarningsView extends StatelessWidget {
  const EarningsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget itemBuilder(BuildContext context, int index) {
      return TypeItem(
        iconPath:
            'https://i.pinimg.com/originals/45/87/0c/45870c609864fdded4b8869276f57314.jpg',
        title: listEarning[index].title ?? '',
        // _onCategoryView(context),
      );
    }
    return Column(
      children: [
        const SizedBox(
          height: 10.0,
        ),
       
        Expanded(
          child: GridView.builder(
              scrollDirection: Axis.vertical,
              itemCount: listEarning.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 6 / 2,
              ),
              itemBuilder: itemBuilder),
        ),
      ],
    );
  }
}
