

import 'dart:ui';

import 'package:flutter/material.dart';

class TbSystemConfig {
  factory TbSystemConfig() => _getInstance();

  static TbSystemConfig get instance => _getInstance();

  static TbSystemConfig? _instance;

  TbSystemConfig._create();

  static TbSystemConfig _getInstance() {
    if (_instance == null) {
      _instance = TbSystemConfig._create();
    }
    return _instance!;
  }
  Color mStatusBarColor = Colors.transparent; //顶部状态栏颜色
  Color mNavigationColor = Colors.black87; //底部状态栏颜色
  double mStandardSize = 750; //依赖标准尺寸


 Color mSnackbarBackground =Color(0x80000000);
 Color mSnackbarTextColor =Colors.white;

  final RouteObserver<Route<dynamic>> routeObserver = RouteObserver();


}
