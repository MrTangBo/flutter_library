import 'package:flutter/material.dart';
import 'package:flutter_library/flutter_library.dart';

import 'home_page.dart';
import 'log_page.dart';
import 'me_page.dart';
import 'square_page.dart';
import 'transation_page.dart';

class MainAct extends StatefulWidget {
  const MainAct({Key? key}) : super(key: key);

  @override
  _RoutePageState createState() => _RoutePageState();
}

const Map<String, String> _bottomNames = {
  "home": "首页",
  "transation": "交易",
  "maidan": "广场",
  "log": "日志",
  "me": "我的"
};

class _RoutePageState extends State<MainAct> {
  final List<Widget> _mPage = [
    HomePage(),
    TransationPage(),
    SquarePage(),
    LogPage(),
    MePage()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TbBottomNavigationWidget(
        pages: _mPage,


        titles: _bottomNames.values.toList(),
        iconPath: _bottomNavigationBar(),
      ),
      floatingActionButton: Container(
        width: 40.px,
        height: 40.px,
        margin: EdgeInsets.only(top: 50.px),
      ),
    );
  }

  Map<String, String> _bottomNavigationBar() {
    Map<String, String> map = {};
    _bottomNames.forEach((key, value) {
      map["assets/images/${key}_unselect.png"] =
          "assets/images/${key}_select.png";
    });
    return map;
  }
}
