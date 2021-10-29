import 'package:flutter/material.dart';
import 'package:flutter_library/flutter_library.dart';

class SquarePage extends StatefulWidget {
  const SquarePage({Key? key}) : super(key: key);

  @override
  _SquarePageState createState() => _SquarePageState();
}

class _SquarePageState extends State<SquarePage> {
  @override
  Widget build(BuildContext context) {
    var list = [Text("data"), Text("data"), Text("data")];

    return SafeArea(
      top: true,
      child: Container(
          color: Colors.white,
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    TbTabLayoutWidgetLogic.getLoic().addTabs(list);
                  },
                  child: Text("add")),
              Expanded(
                child: TbTabLayoutWidget(
                  tabs: list,
                  isScrollable: true,
                  indicatorFullTab: false,
                  onlyTabBar: false,
                  tabBarHeight: 58.px,
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  labelColor: Colors.deepPurple,
                  indicatorColor: Colors.deepPurple,
                  // indicator: ShapeDecoration(color: Colors.red,shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)) ),
                  builder: (context,index){
                    return Text("data$index");
                  },
                  onSelectListener: (controller, index) {
                    Fluttertoast.showToast(msg: "$index");
                  },
                ),
              )
            ],
          )),
    );
  }
}
