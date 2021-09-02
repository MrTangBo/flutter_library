part of flutter_library;

/*设置空布局*/
Widget tbSetEmptyWidget(
    {Widget? icon,
    String? describe,
    Color? iconColor,
    Color? txColor,
    double? textSize,
    Size? iconSize,
    GestureTapCallback? onTap}) {
  return InkWell(
    onTap: onTap,
    child: tbSetMutableWidget(
        icon ??
            SvgPicture.asset(
              "assets/icon_no_data.svg",
              package: "flutter_library",
              color: iconColor ?? Colors.grey,
              width: iconSize?.width ?? 70.px,
              height: iconSize?.width ?? 70.px,
            ),
        describe ?? "no_data".tr,
        txColor ?? Colors.grey,
        textSize ?? 14.px),
  );
}

/*设置无网络*/
Widget tbSetNoInternetWidget(
    {Widget? icon,
    String? describe,
    Color? iconColor,
    Color? txColor,
    double? textSize,
    Size? iconSize,
    GestureTapCallback? onTap}) {
  return InkWell(
    onTap: onTap,
    child: tbSetMutableWidget(
        icon ??
            SvgPicture.asset(
              "assets/icon_no_internet.svg",
              package: "flutter_library",
              color: iconColor ?? Colors.grey,
              width: iconSize?.width ?? 70.px,
              height: iconSize?.width ?? 70.px,
            ),
        describe ?? "no_internet".tr,
        txColor ?? Colors.grey,
        textSize ?? 14.px),
  );
}

/*设置失败布局*/
Widget tbSetFailedWidget(
    {Widget? icon,
    String? describe,
    Color? iconColor,
    Color? txColor,
    double? textSize,
    Size? iconSize,
    GestureTapCallback? onTap}) {
  return InkWell(
    onTap: onTap,
    child: tbSetMutableWidget(
        icon ??
            SvgPicture.asset(
              "assets/icon_failed.svg",
              package: "flutter_library",
              color: iconColor ?? Colors.grey,
              width: iconSize?.width ?? 70.px,
              height: iconSize?.width ?? 70.px,
            ),
        describe ?? "quest_failed".tr,
        txColor ?? Colors.grey,
        textSize ?? 14.px),
  );
}

Widget tbSetMutableWidget(
    Widget icon, String describe, Color txColor, double textSize) {
  return Container(
    color: Colors.white,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        Divider(
          height: 10.px,
        ),
        Text(
          describe,
          style: TextStyle(color: txColor, fontSize: textSize),
        )
      ],
    ),
  );
}

/*若需要组件显示例如空布局，加载失败，无网络可使用此组件*/
typedef BackWidget = Widget Function();

Widget tbGetBuilder<T extends TbBaseLogic>(
    {Key? key,
    String? tag,
    Object? id,
    assignId: true,
    Widget? icon,
    String? describe,
    Color? iconColor,
    Color? txColor,
    double? textSize,
    Size? iconSize,
    GestureTapCallback? onTap,
    required BackWidget builder}) {
  return GetBuilder<T>(
    key: key,
    assignId: assignId,
    builder: (logic) {
      if (logic.mState?.mQuestStatus == QuestStatus.error ||
          logic.mState?.mQuestStatus == QuestStatus.failed) {
        return tbSetFailedWidget(
            icon: icon,
            describe: describe,
            iconColor: iconColor,
            txColor: txColor,
            textSize: textSize,
            iconSize: iconSize,
            onTap: onTap);
      } else if (logic.mState?.mQuestStatus == QuestStatus.noInternet) {
        return tbSetNoInternetWidget(
            icon: icon,
            describe: describe,
            iconColor: iconColor,
            txColor: txColor,
            textSize: textSize,
            iconSize: iconSize,
            onTap: onTap);
      } else if (logic.mState?.mQuestStatus == QuestStatus.noData) {
        return tbSetEmptyWidget(
            icon: icon,
            describe: describe,
            iconColor: iconColor,
            txColor: txColor,
            textSize: textSize,
            iconSize: iconSize,
            onTap: onTap);
      }
      return builder();
    },
    tag: tag,
    id: id,
  );
}



/*刷新嵌套组件扩展*/
Widget tbRefreshCustomWidget<T extends TbBaseLogic>(
    {required T? logic,
    required List<Widget> slivers,
    bool enableInfiniteLoad = false,//无限加载
    bool openRefresh = true,
    bool openLoad = true,
    bool isDark =true}) {

  dynamic tbRefreshHeader = openRefresh ? (isDark?TbSystemConfig.tbRefreshHeaderDark:TbSystemConfig.tbRefreshHeaderLight) : null;
  dynamic tbRefreshFooter =openLoad ? (isDark?TbSystemConfig.tbRefreshFooterDark:TbSystemConfig.tbRefreshFooterLight) : null;

  return EasyRefresh.custom(
    enableControlFinishRefresh: true,
    enableControlFinishLoad: true,
    taskIndependence: false,
    controller: logic?.mState?.mRefreshController,
    footer: tbRefreshFooter,
    header: tbRefreshHeader,
    slivers:slivers ,
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
      bool enableInfiniteLoad = false,//无限加载
      bool openRefresh = true,
      bool openLoad = true,
      bool isDark =true}) {

  dynamic tbRefreshHeader = openRefresh ? (isDark?TbSystemConfig.tbRefreshHeaderDark:TbSystemConfig.tbRefreshHeaderLight) : null;
  dynamic tbRefreshFooter =openLoad ? (isDark?TbSystemConfig.tbRefreshFooterDark:TbSystemConfig.tbRefreshFooterLight) : null;

  return EasyRefresh(
    enableControlFinishRefresh: true,
    enableControlFinishLoad: true,
    taskIndependence: false,
    controller: logic?.mState?.mRefreshController,
    footer: tbRefreshFooter,
    header: tbRefreshHeader,
    child:child ,
    onRefresh: () async {
      logic?.onRefresh();
    },
    onLoad: () async {
      logic?.onLoadMore();
    },
  );
}
