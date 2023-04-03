part of flutter_library;

typedef StatusWidget = Widget Function();
typedef RefreshHeaderClass = Header Function();
typedef RefreshFooterClass = Footer Function();

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
  Color mNavigationColor = Colors.transparent; //底部状态栏颜色
  Brightness brightness = Brightness.dark;
  double mStandardSize = 750; //依赖标准尺寸

  Color mSnackbarBackground = Color(0x80000000);
  Color mSnackbarTextColor = Colors.white;
  static dynamic mSnackbarTextSize = 15.px;
  static String proxyStr = "";

  final RouteObserver<Route<dynamic>> routeObserver = RouteObserver();

  /*全局Context*/
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /*全局refresh header footer*/

  RefreshHeaderClass tbRefreshHeaderDark = () {
    return TbClassicalHeader(
        refreshedText: "refreshedText".tr,
        refreshFailedText: "refreshFailedText".tr,
        refreshingText: "refreshingText".tr,
        refreshReadyText: "refreshReadyText".tr,
        refreshText: "refreshText".tr,
        infoColor: Color(0xff8F9EAB),
        textColor: Color(0xff8F9EAB),
        infoText: "infoText".tr);
  };
  RefreshFooterClass tbRefreshFooterDark = () {
    return TbClassicalFooter(
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
  };

  RefreshHeaderClass tbRefreshHeaderLight = () {
    return TbClassicalHeader(
        refreshedText: "refreshedText".tr,
        refreshFailedText: "refreshFailedText".tr,
        refreshingText: "refreshingText".tr,
        refreshReadyText: "refreshReadyText".tr,
        refreshText: "refreshText".tr,
        infoColor: Colors.white,
        textColor: Colors.white,
        infoText: "infoText".tr);
  };
  RefreshFooterClass tbRefreshFooterLight = () {
    return TbClassicalFooter(
        enableInfiniteLoad: false,
        //无限加载
        loadedText: "loadedText".tr,
        loadFailedText: "loadFailedText".tr,
        loadingText: "loadingText".tr,
        loadReadyText: "loadReadyText".tr,
        infoText: "infoText".tr,
        loadText: "loadText".tr,
        infoColor: Colors.white,
        textColor: Colors.white,
        showInfo: false,
        padding: EdgeInsets.only(left: 50.px, right: 50.px));
  };

  /*空布局*/
  StatusWidget tbEmptyWidget = () {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/icon_no_data.svg",
            package: "flutter_library",
            color: Colors.grey,
            width: 70.px,
            height: 70.px,
          ),
          Divider(
            height: 10.px,
          ),
          Text(
            "no_data".tr,
            style: TextStyle(color: Colors.grey, fontSize: 14.px),
          )
        ],
      ),
    );
  };

  /*无网络显示*/
  StatusWidget tbNoInternetWidget = () {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/icon_no_internet.svg",
            package: "flutter_library",
            color: Colors.grey,
            width: 70.px,
            height: 70.px,
          ),
          Divider(
            height: 10.px,
          ),
          Text(
            "no_internet".tr,
            style: TextStyle(color: Colors.grey, fontSize: 14.px),
          )
        ],
      ),
    );
  };

  /*加载失败显示*/
  StatusWidget tbFailedWidget = () {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/icon_failed.svg",
            package: "flutter_library",
            color: Colors.grey,
            width: 70.px,
            height: 70.px,
          ),
          Divider(
            height: 10.px,
          ),
          Text(
            "quest_failed".tr,
            style: TextStyle(color: Colors.grey, fontSize: 14.px),
          )
        ],
      ),
    );
  };
}
