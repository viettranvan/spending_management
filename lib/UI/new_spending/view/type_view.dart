import 'package:flutter/material.dart';

import '../../../utils/utils.dart';
import '../widgets/search_bar.dart';

class TypeView extends StatelessWidget {
  const TypeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
