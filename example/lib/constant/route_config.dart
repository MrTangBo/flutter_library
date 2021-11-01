import 'package:example/view/main/MainAct.dart';
import 'package:example/view/main/navigation_page.dart';
import 'package:example/view/splash/SplashAct.dart';
import 'package:flutter_library/flutter_library.dart';

/*路由管理*/
class RouteConfig {
  static final root = "/";
  static final main = "/MainAct";
  static final navigation = "/navigation";

  static final routePages = [
    GetPage(name: "/", page: () => SplashAct()),
    GetPage(name: main, page: () => MainAct(), middlewares: []),
    GetPage(name: navigation, page: () => NavigationPage(), middlewares: []),
  ];
}
