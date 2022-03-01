import 'package:flutter/material.dart';
import 'package:spending_management/utils/utils.dart';

class MyFlexiableAppBar extends StatelessWidget {
  final double appBarHeight = 66.0;

  const MyFlexiableAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    String month = '3';
    String year = '2022';
    String money = '100.000';
    
    
    return Container(
      padding: EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + appBarHeight,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://wallpaperaccess.com/full/1857434.jpg',
        
          ),
          fit: BoxFit.cover,
        )
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: Colors.white, width: 1.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.calendar_today_rounded,
                        color: Colors.white,
                        size: 18.0,
                      ),
                      Text(
                        " Tháng $month, $year",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Text(
                    "0 VND",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 30.0),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text('Thu: $money vnd'),
                      ),
                      Expanded(
                        child: Text('Chi: $money vnd'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, right: 8.0),
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.white,
                        size: 20.0,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        getDateNow(),
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
