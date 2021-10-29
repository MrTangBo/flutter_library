import 'package:example/view/main/search_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_library/flutter_library.dart';

class MePage extends StatefulWidget {
  const MePage({Key? key}) : super(key: key);

  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends TbBaseView {
  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text("dsa"),
        centerTitle: false,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Center(
          child: ElevatedButton(
            child: Text("MePag1"),
            onPressed: () {
              Get.to(() => SearchOrder());
            },
          ),
        ),
      ),
    );
  }
}
