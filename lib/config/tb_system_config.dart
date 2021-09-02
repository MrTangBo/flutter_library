part of flutter_library;

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

  Color mSnackbarBackground = Color(0x80000000);
  Color mSnackbarTextColor = Colors.white;
  static dynamic mSnackbarTextSize = 15.px;

  final RouteObserver<Route<dynamic>> routeObserver = RouteObserver();

  /*全局Context*/
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /*全局refresh header footer*/


 static TbClassicalHeader tbRefreshHeaderDark = TbClassicalHeader(
    refreshedText: "refreshedText".tr,
    refreshFailedText: "refreshFailedText".tr,
    refreshingText: "refreshingText".tr,
    refreshReadyText: "refreshReadyText".tr,
    refreshText: "refreshText".tr,
    infoColor:  Color(0xff8F9EAB),
    textColor: Color(0xff8F9EAB),
    infoText: "infoText".tr
  );
  static TbClassicalFooter tbRefreshFooterDark = TbClassicalFooter(
      enableInfiniteLoad: false,
      //无限加载
      loadedText: "loadedText".tr,
      loadFailedText: "loadFailedText".tr,
      loadingText: "loadingText".tr,
      loadReadyText: "loadReadyText".tr,
      infoText: "infoText".tr,
      loadText: "loadText".tr,
      textColor: Color(0xff8F9EAB),
      infoColor: Color(0xff8F9EAB),
      showInfo: false,
      padding: EdgeInsets.only(left: 50.px, right: 50.px));

  static  TbClassicalHeader tbRefreshHeaderLight = TbClassicalHeader(
      refreshedText: "refreshedText".tr,
      refreshFailedText: "refreshFailedText".tr,
      refreshingText: "refreshingText".tr,
      refreshReadyText: "refreshReadyText".tr,
      refreshText: "refreshText".tr,
      infoColor:  Colors.white,
      textColor:  Colors.white,
      infoText: "infoText".tr
  );
  static TbClassicalFooter tbRefreshFooterLight  = TbClassicalFooter(
      enableInfiniteLoad: false,
      //无限加载
      loadedText: "loadedText".tr,
      loadFailedText: "loadFailedText".tr,
      loadingText: "loadingText".tr,
      loadReadyText: "loadReadyText".tr,
      infoText: "infoText".tr,
      loadText: "loadText".tr,
      infoColor:  Colors.white,
      textColor:  Colors.white,
      showInfo: false,
      padding: EdgeInsets.only(left: 50.px, right: 50.px));

}




