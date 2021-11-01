import 'package:example/constant/route_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_library/flutter_library.dart';

import 'home_page.dart';

class SquarePage extends StatefulWidget {
  const SquarePage({Key? key}) : super(key: key);

  @override
  _SquarePageState createState() => _SquarePageState();
}

class _SquarePageState extends TbBaseView<TbBaseLogic,TbBaseState,SquarePage> {

  int currentIndex =0;

  @override
  Widget buildWidget(BuildContext context) {

    return SafeArea(
      top: true,
      child: Container(
          color: Colors.white,
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    TbTabLayoutWidgetLogic.getLoic().addTabs([Text("电影")]);
                  },
                  child: Text("add")),
              Expanded(
                child: TbTabLayoutWidget(
                  tabs: [Text("电影")],
                  isScrollable: true,
                  indicatorFullTab: false,
                  onlyTabBar: false,
                  tabBarHeight: 58.px,
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  labelColor: Colors.deepPurple,
                  indicatorColor: Colors.deepPurple,
                  // indicator: ShapeDecoration(color: Colors.red,shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)) ),
                  builder: (context,index){
                    return tbRefreshWidget(logic: mLogic,child: ElevatedButton(onPressed: (){
                      Get.toNamed(RouteConfig.navigation);
                    },child: Text("data$index")));
                  },
                  onSelectListener: (controller, index) {
                    currentIndex =index;
                    Fluttertoast.showToast(msg: "$index");
                  },
                ),
              )
            ],
          )),
    );
  }

}
