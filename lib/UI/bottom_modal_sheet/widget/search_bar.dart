import 'package:flutter/material.dart';
import 'package:spending_management/utils/utils.dart';

class SearchBar extends StatefulWidget {
  final String hintText;
  const SearchBar({Key? key, required this.hintText}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool _click = false;
  bool _changeColorIcon = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: TextFormField(
        cursorColor: AppColor.background,
        style: const TextStyle(
          fontSize: 12,
        ),
        onTap: () {
          setState(() {
            _changeColorIcon = !_changeColorIcon;
            _click = true;
          });
        },
        onFieldSubmitted: (value) {
          setState(() {
            if (value.isEmpty) {
              _click = false;
            }
            _changeColorIcon = !_changeColorIcon;
          });
        },
        textAlign: _click ? TextAlign.start : TextAlign.center,
        textInputAction: TextInputAction.search,
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
          hintText: widget.hintText,
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
