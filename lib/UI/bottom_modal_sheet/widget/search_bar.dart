import 'dart:async';

import 'package:flutter/material.dart';
import 'package:spending_management/utils/utils.dart';

class SearchBar extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Function() onChangeText;

  const SearchBar({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.onChangeText,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    Timer? _debounce;
    return SizedBox(
      height: 32,
      child: TextFormField(
        cursorColor: AppColor.background,
        style: const TextStyle(
          fontSize: 12,
        ),
        onChanged: (value) {
          if (_debounce?.isActive ?? false) _debounce?.cancel();
          _debounce = Timer(const Duration(milliseconds: 1), () {
            onChangeText();
          });
        },
        textInputAction: TextInputAction.search,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: const Padding(
            padding: EdgeInsets.only(top: 6.0, bottom: 6.0, right: 6.0),
            child: Icon(
              Icons.search,
              color: AppColor.white,
            ),
          ),
          focusColor: AppColor.grey,
          fillColor: AppColor.grey,
          hintStyle: kTextSize12w400White,
          isCollapsed: true,
          hintText: hintText,
          contentPadding:
              const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 40.0),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: AppColor.white,
                width: 1.5,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: AppColor.grey,
                width: 1.5,
              )),
        ),
      ),
    );
  }
}
