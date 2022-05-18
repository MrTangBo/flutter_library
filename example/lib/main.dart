import 'package:example/constant/route_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_library/flutter_library.dart';
import 'constant/api_config.dart';
import 'view/splash/SplashAct.dart';

void main() {
  runApp(MyApp());
  TbAppTheme.setSystemUi();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TbHttpUtils.instance
      ..mPoxyUrl="192.168.1.114:8888"
      ..mErrorCodeHandle = (code, msg, taskId) {
        //统一处理各种ErrorCode
      }
      ..init();

    return GetMaterialApp(
      translations: TbBaseGlobalization(),
      // 将会按照此处指定的语言翻译
      locale: Locale('zh', 'CN'),
      // 添加一个回调语言选项，以备上面指定的语言翻译不存在
      fallbackLocale: Locale('zh', 'CN'),
      initialRoute: RouteConfig.root,
      getPages: RouteConfig.routePages,
      home: SplashAct(),
      builder: EasyLoading.init(builder: (context, widget) {
        SizeUtil.initialize();
        EasyLoading.instance
          ..displayDuration = const Duration(milliseconds: 2000)
          ..indicatorType = EasyLoadingIndicatorType.fadingCircle
          ..maskType = EasyLoadingMaskType.custom
          ..loadingStyle = EasyLoadingStyle.custom
          ..indicatorSize = 50.px
          ..radius = 10.px
          ..fontSize = 15.px
          ..progressColor = Colors.white
          ..backgroundColor = Color(0x80000000)
          ..indicatorColor = Colors.white
          ..textColor = Colors.white
          ..maskColor = Color(0x00000000)
          ..userInteractions = true
          ..dismissOnTap = false;
        return Theme(
          data: TbAppTheme.mThemeData.copyWith(platform: TargetPlatform.iOS),
          child: MediaQuery(
            //设置文字大小不随系统设置改变
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget!,
          ),
        );
      }),
      navigatorObservers: [TbSystemConfig.instance.routeObserver],
      navigatorKey: TbSystemConfig.instance.navigatorKey,
    );
  }
}
