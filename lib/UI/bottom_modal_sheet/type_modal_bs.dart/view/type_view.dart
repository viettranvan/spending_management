import 'package:flutter/material.dart';
import 'package:spending_management/utils/utils.dart';
import 'dart:ui' as ct;

import '../../spending/mockdata/spending_data.dart';
import '../../widget/widget.dart';

class TemplatePage extends StatefulWidget {
  static show(BuildContext context, Function(String?) selectedCallback) {
    showModalBottomSheet(
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
          child: TemplatePage(
            selectedCallback: selectedCallback,
          ),
        );
      },
    );
  }

  final Function(String?) selectedCallback;
  const TemplatePage({Key? key, required this.selectedCallback})
      : super(key: key);

  @override
  State<TemplatePage> createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {
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
        child: TemplateList(),
      ),
    );
  }
}

class TemplateList extends StatefulWidget {
  const TemplateList({
    Key? key,
  }) : super(key: key);

  @override
  State<TemplateList> createState() => _TemplateListState();
}

class _TemplateListState extends State<TemplateList>
    with SingleTickerProviderStateMixin {
  List<Tab> tabs = const <Tab>[
    Tab(text: 'Chi tiêu'),
    Tab(text: 'Thu nhập'),
  ];
  late final controller;
  @override
  void initState() {
    controller = TabController(length: tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget itemBuilder(BuildContext context, int index) {
      return TemplateItem(
          imgUrl: lstCategory.elementAt(index)['url'],
          title: 'TEMPLATE hh',
          isLock: false,
          onTap: () => {}
          // _onCategoryView(context),
          );
    }

    return Scaffold(
      backgroundColor: AppColor.background,
      body: Stack(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  const HeaderModalBS(),
                  DefaultTabController(
                    length: tabs.length,
                    child: TabBar(
                      controller: controller,
                      tabs: tabs,
                      labelColor: AppColor.iconColorStart,
                      unselectedLabelColor: AppColor.white,
                      indicatorColor: AppColor.iconColorStart,
                      labelStyle: kTextSize15w400White,
                      indicator: const UnderlineTabIndicator(
                        borderSide: BorderSide(color: AppColor.iconColorStart),
                      ),
                      onTap: (int index) {
                        // context.read<TypeBloc>().add(ChangeTab(index: index));
                      },
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: controller,
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              height: 10.0,
                            ),
                            const SearchBar(hintText: 'Search elements'),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Expanded(
                              child: ListView(
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                children: [
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    height: 136,
                                    child: GridView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 2,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1,
                                          crossAxisSpacing: 8,
                                          mainAxisSpacing: 8,
                                          childAspectRatio: 1,
                                        ),
                                        itemBuilder: itemBuilder),
                                  ),
                                  SizedBox(
                                    height: 136,
                                    child: GridView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 2,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1,
                                          crossAxisSpacing: 8,
                                          mainAxisSpacing: 8,
                                          childAspectRatio: 1,
                                        ),
                                        itemBuilder: itemBuilder),
                                  ),
                                  SizedBox(
                                    height: 136,
                                    child: GridView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 2,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1,
                                          crossAxisSpacing: 8,
                                          mainAxisSpacing: 8,
                                          childAspectRatio: 1,
                                        ),
                                        itemBuilder: itemBuilder),
                                  ),
                                  SizedBox(
                                    height: 136,
                                    child: GridView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 2,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1,
                                          crossAxisSpacing: 8,
                                          mainAxisSpacing: 8,
                                          childAspectRatio: 1,
                                        ),
                                        itemBuilder: itemBuilder),
                                  ),
                                  SizedBox(
                                    height: 136,
                                    child: GridView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 2,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1,
                                          crossAxisSpacing: 8,
                                          mainAxisSpacing: 8,
                                          childAspectRatio: 1,
                                        ),
                                        itemBuilder: itemBuilder),
                                  ),
                                  SizedBox(
                                    height: 136,
                                    child: GridView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 2,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1,
                                          crossAxisSpacing: 8,
                                          mainAxisSpacing: 8,
                                          childAspectRatio: 1,
                                        ),
                                        itemBuilder: itemBuilder),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Center(
                          child: Text('def'),
                        )
                      ],
                    ),
                  ),
                  // Expanded(
                  //   child: ListView(
                  //     physics: const ScrollPhysics(),
                  //     shrinkWrap: true,
                  //     children: [
                  //       const SizedBox(height: 8),
                  //       SizedBox(
                  //         height: 136,
                  //         child: GridView.builder(
                  //             scrollDirection: Axis.horizontal,
                  //             itemCount: 2,
                  //             gridDelegate:
                  //                 const SliverGridDelegateWithFixedCrossAxisCount(
                  //               crossAxisCount: 1,
                  //               crossAxisSpacing: 8,
                  //               mainAxisSpacing: 8,
                  //               childAspectRatio: 1,
                  //             ),
                  //             itemBuilder: itemBuilder),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              )),
        ],
      ),
    );
  }
}

class TemplateItem extends StatefulWidget {
  final String imgUrl;
  final String title;
  final VoidCallback? onTap;
  final bool isLock;

  const TemplateItem({
    Key? key,
    required this.imgUrl,
    required this.title,
    this.isLock = false,
    this.onTap,
  }) : super(key: key);

  @override
  _TemplateItemState createState() => _TemplateItemState();
}

class _TemplateItemState extends State<TemplateItem> {
  Color _bgColor = Colors.transparent;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {
              widget.isLock
                  ? widget.onTap?.call()
                  : {Navigator.of(context).pop()},
              setState(() => _bgColor = Colors.transparent)
            },
        onTapDown: (tapDetails) {
          setState(() => _bgColor = AppColor.grey);
        },
        onTapCancel: () {
          setState(() => _bgColor = Colors.transparent);
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColor.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Center(
                child: Text(widget.title, style: kTextSize15w400Blue),
              ),
              Visibility(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Stack(
                    children: const [
                      const Icon(Icons.lock),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Icon(Icons.person),
                        ),
                      ),
                    ],
                  ),
                ),
                visible: widget.isLock,
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                color: _bgColor,
              )
            ],
          ),
        ));
  }
}
