import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'log_page.dart';
import 'me_page.dart';
import 'square_page.dart';
import 'transation_page.dart';
import 'package:flutter_library/flutter_library.dart';

class MainAct extends StatefulWidget {
  const MainAct({Key? key}) : super(key: key);

  @override
  _RoutePageState createState() => _RoutePageState();
}

const Map _bottomNames = {
  "home": "首页",
  "transation": "交易",
  "maidan": "广场",
  "log": "日志",
  "me": "我的"
};

class _RoutePageState extends State<MainAct> {
  List<BottomNavigationBarItem> _bottomTabList = [];
  int _mCurrentIndex = 0;

  PageController controller = PageController();

  final List<Widget> _mPage = [
    HomePage(),
    TransationPage(),
    SquarePage(),
    LogPage(),
    MePage()
  ];

  @override
  void initState() {
    super.initState();
    _bottomNames.forEach((key, value) {
      _bottomTabList.add(_bottomNavigationBar(key, value));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          return _mPage[index];
        },
        onPageChanged: (index){
         setState(() {
           _mCurrentIndex =index;
         });
        },
        controller: controller,
        itemCount: _mPage.length,
      ),

      // IndexedStack(
      //   children: _mPage,
      //   index: _mCurrentIndex,
      // ),

      bottomNavigationBar: BottomNavigationBar(
        items: _bottomTabList,
        currentIndex: _mCurrentIndex,
        onTap: (index) {
          setState(() {
            _mCurrentIndex = index;
            controller.jumpToPage(index);
            // controller.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.linear);
          });
        },
      ),
      floatingActionButton: Container(
        width: 40.px,
        height: 40.px,
        margin: EdgeInsets.only(top: 50.px),
      ),
    );
  }

  BottomNavigationBarItem _bottomNavigationBar(String key, String value) {
    return BottomNavigationBarItem(
        icon: Image.asset(
          'assets/images/${key}_unselect.png',
          width: 20.px,
          height: 20.px,
        ),
        activeIcon: Image.asset(
          'assets/images/${key}_select.png',
          width: 20.px,
          height: 20.px,
        ),
        label: value,
        tooltip: "");
  }
}
