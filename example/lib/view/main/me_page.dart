import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_library/flutter_library.dart';

import 'search_order.dart';

class MePage extends StatefulWidget {
  const MePage({Key? key}) : super(key: key);

  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends TbBaseWidgetState {
  @override
  Widget buildWidget(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: ElevatedButton(child: Text("MePage"),onPressed: (){
          Get.to(()=>SearchOrder());
        },),
      ),
    );
  }

  @override
  void initViewState() {

  }
}
