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

  bool _mBuildComplete = false;

  ConnectivityResult? _mNetWorkStatus; //当前网络状态

  @override
  void initState() {
    super.initState();
    initView();
    WidgetsBinding.instance
      ?..addObserver(this) //添加观察者
      ..addPostFrameCallback((timeStamp) {
        if (!_mBuildComplete) {
          firstFrameComplete();
          _mBuildComplete = true;
        }
      });
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
  void initViewState() {}

  @protected
  Widget buildWidget(BuildContext context);

  @override
  bool get wantKeepAlive => false;

  initView() {
    initViewState();
    initInternetStatus();
  }

  void firstFrameComplete() {
    //第一帧渲染完成监听
  }

  void initInternetStatus() {
    mState?.mRefreshController =EasyRefreshController();
    Connectivity().checkConnectivity().then((value) {
      //获取当前的网络
      _mNetWorkStatus = value;
      if(value==ConnectivityResult.none){
        mState?.mRefreshController =EasyRefreshController();
      }
    });
    TbHttpUtils.instance
      ..mNetWorkHandle = (status) {
        if (_mNetWorkStatus == status) return;
        _mNetWorkStatus = status;
        if (status == ConnectivityResult.mobile) {
          showCustomTopSnackBar("internet_mobile".tr);
        } else if (status == ConnectivityResult.none) {
          showCustomTopSnackBar("no_internet".tr);
          mState?.mQuestStatus = QuestStatus.noInternet;
          if (TbHttpUtils.instance.mRepeatQuests.length != 0) {
            mLogic?.update();
          }
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
