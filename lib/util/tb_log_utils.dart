part of flutter_library;

log(String str) {
  if (kDebugMode) {
    print("$str");
  }
}

showCustomTopSnackBar(String str) {
  Future.delayed(Duration(seconds: 0)).then((onValue) {
    BuildContext? context =
        TbSystemConfig.instance.navigatorKey.currentState?.overlay?.context;
    if (context == null) return;
    showTopSnackBar(
        context,
        CustomSnackBar.info(
          icon: Icon(Icons.sentiment_neutral,
              color: const Color(0x15000000), size: 0),
          message: str,
          backgroundColor: TbSystemConfig.instance.mSnackbarBackground,
          textStyle: TextStyle(
              fontWeight: FontWeight.w600,
              color: TbSystemConfig.instance.mSnackbarTextColor,
              fontSize: TbSystemConfig.mSnackbarTextSize),
        ));
  });
}
