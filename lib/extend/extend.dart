part of flutter_library;

/*设置空布局*/
Widget tbSetStatusWidget({Widget? child, GestureTapCallback? onTap}) {
  return InkWell(
    onTap: onTap,
    child: child,
  );
}

/*若需要组件显示例如空布局，加载失败，无网络可使用此组件*/
typedef BackWidget = Widget Function();

Widget tbGetBuilder<T extends TbBaseLogic>(
    {Key? key,
    String? tag,
    Object? id,
    assignId: true,
    GestureTapCallback? onTap,
    required BackWidget builder}) {
  return GetBuilder<T>(
      key: key,
      tag: tag,
      id: id,
      assignId: assignId,
      builder: (logic) {
        if (logic.mState?.mQuestStatus == QuestStatus.error ||
            logic.mState?.mQuestStatus == QuestStatus.failed) {
          return tbSetStatusWidget(
              child: TbSystemConfig.instance.tbFailedWidget(),
              onTap: onTap ??
                  () {
                    logic.tbRefreshQuest();
                  });
        } else if (logic.mState?.mQuestStatus == QuestStatus.noInternet) {
          return tbSetStatusWidget(
              child: TbSystemConfig.instance.tbNoInternetWidget(),
              onTap: onTap ??
                  () {
                    logic.tbRefreshQuest();
                  });
        } else if (logic.mState?.mQuestStatus == QuestStatus.noData) {
          return tbSetStatusWidget(
              child: TbSystemConfig.instance.tbEmptyWidget(),
              onTap: onTap ??
                  () {
                    logic.tbRefreshQuest();
                  });
        }
        return builder();
      });
}

/*刷新嵌套组件扩展*/
Widget tbRefreshCustomWidget<T extends TbBaseLogic>(
    {required T? logic,
    required List<Widget> slivers,
    bool enableInfiniteLoad = false, //无限加载
    bool openRefresh = true,
    bool openLoad = true,
    bool isDark = true}) {
  dynamic tbRefreshHeader = openRefresh
      ? (isDark
          ? TbSystemConfig.instance.tbRefreshHeaderDark()
          : TbSystemConfig.instance.tbRefreshHeaderLight())
      : null;
  dynamic tbRefreshFooter = openLoad
      ? (isDark
          ? TbSystemConfig.instance.tbRefreshFooterDark()
          : TbSystemConfig.instance.tbRefreshFooterLight())
      : null;

  return EasyRefresh.custom(
    enableControlFinishRefresh: true,
    enableControlFinishLoad: true,
    taskIndependence: false,
    controller: logic?.mState?.mRefreshController,
    footer: tbRefreshFooter,
    header: tbRefreshHeader,
    slivers: slivers,
    onRefresh: () async {
      logic?.onRefresh();
    },
    onLoad: () async {
      logic?.onLoadMore();
    },
  );
}

/*常规刷新*/
Widget tbRefreshWidget<T extends TbBaseLogic>(
    {required T? logic,
    required Widget child,
    bool enableInfiniteLoad = false, //无限加载
    bool openRefresh = true,
    bool openLoad = true,
    bool isDark = true}) {
  dynamic tbRefreshHeader = openRefresh
      ? (isDark
          ? TbSystemConfig.instance.tbRefreshHeaderDark()
          : TbSystemConfig.instance.tbRefreshHeaderLight())
      : null;
  dynamic tbRefreshFooter = openLoad
      ? (isDark
          ? TbSystemConfig.instance.tbRefreshFooterDark()
          : TbSystemConfig.instance.tbRefreshFooterLight())
      : null;

  return EasyRefresh(
    enableControlFinishRefresh: true,
    enableControlFinishLoad: true,
    taskIndependence: false,
    controller: logic?.mState?.mRefreshController,
    footer: tbRefreshFooter,
    header: tbRefreshHeader,
    child: child,
    onRefresh: () async {
      logic?.onRefresh();
    },
    onLoad: () async {
      logic?.onLoadMore();
    },
  );
}

/*Map扩展*/
extension customMap on Map<int, String> {
  int get taskId => this.keys.first;

  String get url => this.values.first;
}

/*初始化抓包代理*/
void tbInitProxy() async {
  if (kDebugMode) {
    String proxyStr = "";
    try {
      Map<String, String>? proxy = await SystemProxy.getProxySettings();
      if (proxy != null) {
        proxyStr = '${proxy["host"]}:${proxy["port"]}';
      } else {
        proxyStr = '';
      }
    } on PlatformException {
      proxyStr = '';
    }

    ///配置代理
    TbHttpUtils.instance.mPoxyUrl =
        proxyStr.isNotEmpty ? "PROXY $proxyStr" : "";
  }
}

tbShowToast(String msg,
    {ToastGravity? gravity,
    Color? backgroundColor,
    Color? textColor,
    double? fontSize}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity ?? ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor:
          backgroundColor ?? TbSystemConfig.instance.mSnackbarBackground,
      textColor: textColor ?? TbSystemConfig.instance.mSnackbarTextColor,
      fontSize: fontSize ?? 14.0.px);
}

/*初始化屏幕方向*/
enum ScreenDirect { portrait, landscape }

tbInitScreenDirect({ScreenDirect portrait = ScreenDirect.portrait}) {
  WidgetsFlutterBinding.ensureInitialized(); //不加这个强制横/竖屏会报错
  if (portrait == ScreenDirect.portrait) {
    SystemChrome.setPreferredOrientations([
      // 强制竖屏
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
  } else {
    SystemChrome.setPreferredOrientations([
      // 强制横屏
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
  }
}
