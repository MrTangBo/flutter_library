import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_library/flutter_library.dart';
import '../main/MainAct.dart';


class SplashAct extends StatefulWidget {
  const SplashAct({Key? key}) : super(key: key);

  @override
  _TransitPageState createState() => _TransitPageState();
}

class _TransitPageState extends State<SplashAct> {
  var time = 6;

  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (time > 0) {
          time--;
        } else {
          Get.offNamed("MainAct");
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.color_161F2F,
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/images/icon_welcome_logo.png",
                fit: BoxFit.fill,
                height: 64.px,
                width: 144.px,
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(bottom: 30.px),
              child: Image.asset(
                "assets/images/icon_welcome_tx.png",
                fit: BoxFit.fill,
                height: 20.px,
                width: 170.px,
              ),
            ),
            Positioned(
              child: InkWell(
                child: _clipButton(),
                onTap: (){
                  Get.toNamed("MainAct");
                },
              ),
              right: 10,
              top: MediaQuery.of(context).padding.top + 10,
            )
          ],
        ),
      ),
    );
  }

  Widget _clipButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        alignment: Alignment.center,
        child: Text(
          "跳过$time",
          style: TextStyle(color: Colors.white, fontSize: 13),
        ),
        width: 50,
        height: 50,
        color: Color(0x50000000),
      ),
    );
  }

}
