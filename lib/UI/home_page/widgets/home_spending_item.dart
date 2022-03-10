
import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class HomeSpendingItem extends StatelessWidget {
  const HomeSpendingItem({
    Key? key,
    required this.typeItem,
    required this.type,
    required this.note,
    required this.date,
    required this.iconPath,
    required this.money,
    required this.preDate,
  }) : super(key: key);

  final String typeItem;
  final String note;
  final String iconPath;
  final int money;
  final String type;
  final String date;
  final String preDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: date != preDate,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(date, style: kTextSize20w400White),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: ListTile(
                leading:  CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.white,
                  child: Image.asset(iconPath,fit: BoxFit.cover),
                ),
                title: Text(typeItem, style: kTextSize18w400White),
                subtitle: Text(note.isEmpty ? 'Không có ghi chú' : note,
                    style: kTextSize15w400White),
                isThreeLine: true,
              ),
            ),
            Row(
              children: [
                Text(type == 'spending' ? '-' : '+',
                    style: type == 'spending'
                        ? kTextSize18w400Red
                        : kTextSize18w400Green),
                Text(formatMoney(money.toString()),
                    style: type == 'spending'
                        ? kTextSize18w400Red
                        : kTextSize18w400Green),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
