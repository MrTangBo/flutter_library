part of flutter_library;

class TbAppTheme {
  static ThemeData mThemeData = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: AppColors.color_161F2F,
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: AppColors.color_2c355c, fontSize: 13.px)
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
      unselectedItemColor: AppColors.color_CFD2E7,
    ),
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    indicatorColor: Colors.red,
    tabBarTheme: TabBarTheme(
      unselectedLabelColor: Colors.white,
      labelColor: Colors.red,
    ),
  );

  static setSystemUi(
      {Color? statusColor,
      Color? navigationColor,
      Color? navigationBarDividerColor,
      Brightness? statusBrightness,
      Brightness? navigationBrightness,
      bool isImmersed = false,
      bool mShowNavigationBar = true,
      bool isShowStatusBar = true}) {
    /*设置之前恢复默认系统UI*/
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    if (isImmersed) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
    } else {
      if (!mShowNavigationBar) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: [SystemUiOverlay.top]);
      }
      if (!isShowStatusBar) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: [SystemUiOverlay.bottom]);
      }
    }
    var temp = statusBrightness ?? TbSystemConfig.instance.statusBrightness;
    Brightness iosBrightness;
    if (temp == Brightness.light) {
      iosBrightness = Brightness.dark;
    } else {
      iosBrightness = Brightness.light;
    }
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor:  navigationColor ?? TbSystemConfig.instance.mNavigationColor,
      systemNavigationBarDividerColor: navigationBarDividerColor ?? TbSystemConfig.instance.mNavigationBarDividerColor,
      statusBarColor: statusColor ?? TbSystemConfig.instance.mStatusBarColor,
      systemNavigationBarIconBrightness: navigationBrightness?? TbSystemConfig.instance.navigationBrightness,
      statusBarIconBrightness: temp,
      statusBarBrightness: iosBrightness,
    ));
  }
}
