import 'package:flutter/material.dart';
import '../../../../models/spending_model.dart';
import '../../widget/widget.dart';
import '../mockdata/earning_data.dart';

class EarningsView extends StatelessWidget {
  const EarningsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget itemBuilder(BuildContext context, int index) {
      return GestureDetector(
        onTap: () {
          SpendingModel model = SpendingModel(
            iconPath: listEarning[index].iconPath,
            title: listEarning[index].title,
            spendingType: 'earning',
          );
          Navigator.of(context).pop<SpendingModel>(model);
        },
        child: TypeItem(
          iconPath:
              listEarning[index].iconPath ?? 'assets/images/another_icon.png',
          title: listEarning[index].title ?? '',
          // _onCategoryView(context),
        ),
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
