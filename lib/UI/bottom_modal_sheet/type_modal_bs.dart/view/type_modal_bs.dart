import 'package:flutter/material.dart';
import 'package:spending_management/utils/utils.dart';
import 'dart:ui' as ct;

import '../../../../models/spending_model.dart';
import 'type_modal_bs_view.dart';

class TypeModalBS extends StatefulWidget {
  static Future<SpendingModel?> show(BuildContext context) async{
     SpendingModel? result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (ctx) {
        return SizedBox(
          height: MediaQuery.of(ctx).size.height -
              (MediaQueryData.fromWindow(ct.window).padding.top +
                  kToolbarHeight) -
              100,
          child: const TypeModalBS(),
        );
      },
    );
    return result;
  }

  const TypeModalBS({Key? key})
      : super(key: key);

  @override
  State<TypeModalBS> createState() => _TypeModalBSState();
}

class _TypeModalBSState extends State<TypeModalBS> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: const AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: TypeModalBSView(),
      ),
    );
  }
}
