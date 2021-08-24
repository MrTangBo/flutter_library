part of flutter_library;


class TbAppTheme {
  static init() {
    SizeUtil.initialize(standardSize: TbSystemConfig.instance.mStandardSize);
  }

  static final ThemeData mThemeData = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: AppColors.color_161F2F,
    textTheme: TextTheme(
      bodyText2: TextStyle(color: AppColors.color_2c355c, fontSize: 13.px),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.color_1F2B42,
        selectedItemColor: AppColors.color_2A6AE7,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle:
            TextStyle(fontSize: 12.px, height: 2, fontWeight: FontWeight.w500),
        unselectedLabelStyle:
            TextStyle(fontSize: 12.px, height: 2, fontWeight: FontWeight.w500),
        unselectedItemColor: AppColors.color_CFD2E7),
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    indicatorColor: Colors.red,
    tabBarTheme:
        TabBarTheme(unselectedLabelColor: Colors.white, labelColor: Colors.red),
  );

  static setSystemUi(
      {Color statusColor = Colors.transparent,
      Color navigationColor = Colors.white,
      bool isDark = true,
      bool isImmersed = false,
      bool mShowNavigationBar = true,
      bool isShowStatusBar = true}) {
    /*设置之前恢复默认系统UI*/
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    if (isImmersed) {
      SystemChrome.setEnabledSystemUIOverlays([]);
    } else {
      if (!mShowNavigationBar) {
        SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
      }
      if (!isShowStatusBar) {
        SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
      }
    }
    if (isDark) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: navigationColor,
        systemNavigationBarDividerColor: Colors.transparent,
        statusBarColor: statusColor,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: navigationColor,
        systemNavigationBarDividerColor: Colors.transparent,
        statusBarColor: statusColor,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ));
    }
  }
}
