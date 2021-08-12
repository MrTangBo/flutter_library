import 'package:example/view/main/MainAct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'view/splash/SplashAct.dart';

import 'package:flutter_library/flutter_library.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TbHttpUtils.instance
      ..mBaseUrl = "http://161.117.234.84:18080"
      ..mErrorCodeHandle = (code, msg, taskId) {
        //统一处理各种ErrorCode
      }
      ..init();
    TbAppTheme.init();
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..maskType = EasyLoadingMaskType.custom
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 50.0
      ..radius = 10.0
      ..fontSize = 15.px
      ..progressColor = Colors.white
      ..backgroundColor = Color(0x70000000)
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
      ..maskColor = Color(0x00000000)
      ..userInteractions = true
      ..dismissOnTap = false;

    return GetMaterialApp(
      translations: TbBaseGlobalization(),
      locale: Locale('zh', 'CN'),
      // 将会按照此处指定的语言翻译
      fallbackLocale: Locale('zh', 'CN'),
      // 添加一个回调语言选项，以备上面指定的语言翻译不存在
      theme: TbAppTheme.mThemeData.copyWith(platform: TargetPlatform.iOS),
      // defaultTransition: Transition.rightToLeftWithFade,
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => SplashAct()),
        GetPage(name: "/MainAct", page: () => MainAct(), middlewares: []),

      ],
      title: '渡情',
      home: SplashAct(),
      builder: EasyLoading.init(builder: (context, widget) {
        return MediaQuery(
          //设置文字大小不随系统设置改变
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: widget!,
        );
      }),
      navigatorObservers: [TbSystemConfig.instance.routeObserver],
    );
  }
}
