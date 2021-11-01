import 'package:flutter/material.dart';
import 'package:flutter_library/flutter_library.dart';

import 'home_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState
    extends TbBaseView<TbBaseLogic, TbBaseState, NavigationPage> {
  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      body: TbBottomNavigationWidget(
        pages: [
          Center(
              child: Text(
            "sads",
            style: TextStyle(color: Colors.deepPurple),
          )),
          Center(
              child: Text(
            "sads1",
            style: TextStyle(color: Colors.deepPurple),
          )),
          Center(
              child: Text(
            "sads2",
            style: TextStyle(color: Colors.deepPurple),
          )),
          Center(
              child: Text(
            "sads3",
            style: TextStyle(color: Colors.deepPurple),
          )),
        ],
        titles: ["首页", "交易", "消息", "我的"],
        bottomNavigationBarBgColor: Colors.deepPurple,
        iconPath: {
          "assets/images/home_unselect.png": "assets/images/home_select.png",
          "assets/images/transation_unselect.png": "assets/images/transation_select.png",
          "assets/images/maidan_unselect.png": "assets/images/maidan_select.png",
          "assets/images/log_unselect.png": "assets/images/log_select.png",
        },
      ),
    );
  }
}
