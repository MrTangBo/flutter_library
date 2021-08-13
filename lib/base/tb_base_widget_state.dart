part of flutter_library;

/*state基类*/
abstract class TbBaseWidgetState<T extends TbBaseLogic,
        E extends TbBaseViewState, S extends StatefulWidget> extends State<S>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver, RouteAware {
  T? mLogic;
  E? mState;
  String? mLogicTag;
  int lastPopTime = 0;

  final bool mShowExitTips = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this); //添加观察者
    initView();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
      child: Container(
        child: buildWidget(context),
      ),
      onWillPop: !mShowExitTips
          ? null
          : () async {
              if (EasyLoading.isShow) {
                EasyLoading.dismiss();
                return false;
              }
              // 点击返回键的操作
              int nowTime = DateTime.now().millisecondsSinceEpoch;
              if (nowTime - lastPopTime > 1500) {
                lastPopTime = nowTime;
                Fluttertoast.showToast(
                    msg: 'exit_app'.tr,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor:
                        TbSystemConfig.instance.mSnackbarBackground,
                    textColor: TbSystemConfig.instance.mSnackbarTextColor,
                    fontSize: 14.0);
              } else {
                // 退出app
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              }
              return false;
            },
    );
  }

  setViewState(T logic, E state, {String? logicTag}) {
    this.mLogicTag = logicTag;
    if (logicTag != null) {
      Get.lazyPut<T>(() => logic, tag: logicTag);
      mLogic = Get.find<T>(tag: logicTag);
    } else {
      Get.lazyPut<T>(() => logic);
      mLogic = Get.find<T>();
    }
    mState = state;
    mLogic?.setViewState(mState);
  }

  /*必须吃初始化调用setViewState方法*/
  void initViewState();

  @protected
  Widget buildWidget(BuildContext context);

  @override
  bool get wantKeepAlive => false;

  initView() {
    initViewState();
    initStatusBar();
    initInternetStatus();
  }

  initStatusBar() {
    TbAppTheme.setSystemUi(
        isImmersed: false,
        statusColor: TbSystemConfig.instance.mStatusBarColor,
        navigationColor: TbSystemConfig.instance.mNavigationColor);
  }

  initInternetStatus() {
    TbHttpUtils.instance
      ..mNetWorkHandle = (status) {
        if (status == ConnectivityResult.mobile) {
          Get.snackbar('title_tips'.tr, "internet_mobile".tr,
              backgroundColor: TbSystemConfig.instance.mSnackbarBackground,
              colorText: TbSystemConfig.instance.mSnackbarTextColor);
        } else if (status == ConnectivityResult.none) {
          Get.snackbar('title_tips'.tr, "no_internet".tr,
              backgroundColor: TbSystemConfig.instance.mSnackbarBackground,
              colorText: TbSystemConfig.instance.mSnackbarTextColor);
        }
      };
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.inactive:
        //  应用程序处于闲置状态并且没有收到用户的输入事件。
        //注意这个状态，在切换到后台时候会触发，所以流程应该是先冻结窗口，然后停止UI
        if (Get.currentRoute.contains(widget.runtimeType.toString())) {
          onBackHome();
        }
        break;
      case AppLifecycleState.paused:
//      应用程序处于不可见状态
        if (Get.currentRoute.contains(widget.runtimeType.toString())) {
          onPause();
        }

        break;
      case AppLifecycleState.resumed:
        //    进入应用时候不会触发该状态
        //  应用程序处于可见状态，并且可以响应用户的输入事件。它相当于 Android 中Activity的onResume。
        if (Get.currentRoute.contains(widget.runtimeType.toString())) {
          onResume();
        }

        break;
      case AppLifecycleState.detached:
        //当前页面即将退出
        if (Get.currentRoute.contains(widget.runtimeType.toString())) {
          onDetach();
        }

        break;
    }
  }

  void onBackHome() {}

  void onResume() {}

  void onPause() {}

  void onDetach() {}

  @override
  void didPopNext() {
    onResume();
    super.didPopNext();
  }

  @override
  void didChangeDependencies() {
    TbSystemConfig.instance.routeObserver
        .subscribe(this, ModalRoute.of(context)!); //订阅
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this); //销毁观察者
    TbSystemConfig.instance.routeObserver.unsubscribe(this); //取消订阅
    super.dispose();
  }
}
