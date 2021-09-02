import 'package:example/view/main/search_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_library/flutter_library.dart';

class MePage extends StatefulWidget {
  const MePage({Key? key}) : super(key: key);

  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends TbBaseWidgetState {
  @override
  Widget buildWidget(BuildContext context) {
    return Center(
      child: ElevatedButton(child: Text("MePage"),onPressed: (){
        Get.to(()=>SearchOrder());
      },),
    );
  }
}
