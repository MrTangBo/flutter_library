part of flutter_library;

typedef QuestSuccess = Function(dynamic result, int taskId);
typedef QuestError = Function(dynamic onError);
typedef QuestFailed = Function(dynamic code, dynamic msg, int taskId);

class TbHttpUtils {
  factory TbHttpUtils() => _getInstance();

  static TbHttpUtils get instance => _getInstance();

  static TbHttpUtils? _instance;

  TbHttpUtils._create();

  static TbHttpUtils _getInstance() {
    if (_instance == null) {
      _instance = TbHttpUtils._create();
    }
    return _instance!;
  }

  /*初始化dio*/
  Dio _mDio = Dio();
  dynamic mSuccessCode = "200"; //请求成功状态码
  List jsonKey = ["code", "data", "msg"];
  String mBaseUrl = ""; //单域名设置
  String mContentType = "application/json";
  int mReceiveTimeout = 15; //接收数据的最长时限.
  int mSendTimeout = 15; //发送数据最长时限
  int mConnectTimeout = 15000; // 连接服务器超时时间，单位是毫秒.
  String mPoxyUrl = ""; //代理url
  bool mTrustAllCertificate = true; //信任所有证书
  Map<String, dynamic> mHeader = {};
  List<Interceptor> mInterceptors = []; //自定义拦截器
  Function mLoadingView = () {
    EasyLoading.show(
        status: "loading".tr, maskType: EasyLoadingMaskType.custom);
  }; //加载进度框
  Transformer mTransformer = DefaultTransformer(); // 自定义 jsonDecodeCallback

  ConnectivityResult? _mNetWorkStatus; //当前网络状态

  Function(ConnectivityResult? mNetWorkStatus) mNetWorkHandle =
      (_) {}; //不同网络状态处理
  bool mFirstIntoApp = true; //是否首次进去app(防止进去App去执行无网络的操作，正常情况应该发起请求时执行)

  List<QuestRepeatListInfo> mRepeatQuests = []; //断线重连配置

  bool mShowErrorMsg = kDebugMode; //是否展示请求超时的或者请求错误弹窗提示;(默认debug模式展示)

  QuestFailed mErrorCodeHandle = (_, __, ___) {};//请求失败

  init() {
    _mDio
      ..options = BaseOptions(
          baseUrl: mBaseUrl,
          contentType: mContentType,
          receiveTimeout: mReceiveTimeout,
          sendTimeout: mSendTimeout,
          connectTimeout: mConnectTimeout,
          headers: mHeader)
      ..transformer = mTransformer
      ..interceptors.addAll(mInterceptors)
      //请求拦截器和获取数据拦截器
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            if (kDebugMode) {
              //debug模式允许打印
              log("realUrl-->${options.baseUrl + options.path}\nqueryParameters-->${jsonEncode(options.queryParameters)}\nformData-->${jsonEncode(options.data)}\nheader-->${options.headers}");
            }
            return handler.next(options);
          },
        ),
      );
    //debug模式允许抓包(设置代理)
    if (kDebugMode && mPoxyUrl.isNotEmpty) {
      (_mDio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (uri) {
          return "PROXY $mPoxyUrl";
        };
      };
    }
    //信任所有证书
    (_mDio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => mTrustAllCertificate;
    };

    /*检测网络*/
    Connectivity()
      ..onConnectivityChanged.listen((result) {
        if (_mNetWorkStatus == result) return;
        _mNetWorkStatus = result;
        if (!mFirstIntoApp) {
          mNetWorkHandle(result);
          mFirstIntoApp = false;
        }
        if (_mNetWorkStatus != ConnectivityResult.none) {
          mRepeatQuests.forEach((quest) {
            if (quest.questMethod == QuestMethod.post) {
              post(quest.url!, quest.taskId!,
                  data: quest.data,
                  queryParameters: quest.queryParameters,
                  options: quest.options,
                  onSuccess: quest.onSuccess,
                  onFiled: quest.onFiled,
                  onError: quest.onError);
            } else if (quest.questMethod == QuestMethod.get) {
              get(quest.url!, quest.taskId!,
                  queryParameters: quest.queryParameters,
                  options: quest.options,
                  onSuccess: quest.onSuccess,
                  onFiled: quest.onFiled,
                  onError: quest.onError);
            } else {
              questMix(quest.questListInfos!,
                  onSuccess: quest.onMultipleSuccess,
                  onFiled: quest.onMultipleFiled,
                  onError: quest.onError);
            }
          });
        }
      })
      ..checkConnectivity().then((value) {
        //获取当前的网络
        _mNetWorkStatus = value;
      });
  }

/*单get请求*/
  get(String url, int taskId,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      QuestSuccess? onSuccess,
      QuestError? onError,
      QuestFailed? onFiled,
      bool isShowLoading = true,
      CancelToken? token}) async {
    /*无网络不请求*/
    mFirstIntoApp = false;
    if (_mNetWorkStatus == ConnectivityResult.none) {
      if (mRepeatQuests.where((element) => element.taskId == taskId).length !=
          0) return;
      mRepeatQuests.add(QuestRepeatListInfo(
          url: url,
          questMethod: QuestMethod.get,
          queryParameters: queryParameters,
          options: options,
          taskId: taskId,
          onSuccess: onSuccess,
          onError: onError,
          onFiled: onFiled));
      mNetWorkHandle(_mNetWorkStatus);
      return;
    }
    try {
      _showLoading(isShowLoading);
      var result = await _mDio.get(url,
          queryParameters: queryParameters,
          options: options,
          cancelToken: token);
      mRepeatQuests.removeWhere((element) => taskId == element.taskId);
      if (isShowLoading) {
        EasyLoading.dismiss();
      }
      final info = TbHttpResult.fromJson(jsonDecode(result.toString()));
      if (kDebugMode) {
        log("result-$taskId-->$result");
      }
      if (onSuccess != null) {
        if (info.code == mSuccessCode) {
          onSuccess(info.data, taskId);
        }
      }
      if (onFiled != null) {
        if (info.code != mSuccessCode) {
          onFiled(info.code, info.msg, taskId);
        }
      } else {
        mErrorCodeHandle(info.code, info.msg, taskId);
      }
    } on DioError catch (e) {
      _handleError(e, onError, isShowLoading);
    } finally {}
  }

/*单post请求*/
  post(String url, int taskId,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      QuestSuccess? onSuccess,
      QuestFailed? onFiled,
      QuestError? onError,
      bool isShowLoading = true,
      CancelToken? token}) async {
    mFirstIntoApp = false;
    /*无网络不请求*/
    if (_mNetWorkStatus == ConnectivityResult.none) {
      if (mRepeatQuests.where((element) => element.taskId == taskId).length !=
          0) return;
      mRepeatQuests.add(QuestRepeatListInfo(
          url: url,
          questMethod: QuestMethod.post,
          data: data,
          taskId: taskId,
          queryParameters: queryParameters,
          options: options,
          onSuccess: onSuccess,
          onError: onError,
          onFiled: onFiled));
      mNetWorkHandle(_mNetWorkStatus);
      return;
    }
    try {
      _showLoading(isShowLoading);
      var result = await _mDio.post(url,
          options: options,
          queryParameters: queryParameters,
          data: data,
          cancelToken: token);
      if (isShowLoading) {
        EasyLoading.dismiss();
      }
      mRepeatQuests.removeWhere((element) => taskId == element.taskId);
      final info = TbHttpResult.fromJson(jsonDecode(result.toString()));
      if (kDebugMode) {
        log("result-$taskId-->$result");
      }
      if (onSuccess != null) {
        if (info.code == mSuccessCode) {
          onSuccess(info.data, taskId);
        }
      }
      if (onFiled != null) {
        if (info.code != mSuccessCode) {
          onFiled(info.code, info.msg, taskId);
        }
      } else {
        mErrorCodeHandle(info.code, info.msg, taskId);
      }
    } on DioError catch (e) {
      _handleError(e, onError, isShowLoading);
    } finally {}
  }

  /*并行请求*/
  questMix(List<QuestListInfo> questInfos,
      {QuestSuccess? onSuccess,
      QuestFailed? onFiled,
      QuestError? onError,
      bool isShowLoading = true}) async {
    /*无网络不请求*/
    mFirstIntoApp = false;
    var mTaskIdMix = "";
    questInfos.forEach((element) {
      mTaskIdMix += "${element.mapUrl.url}";
    });
    if (_mNetWorkStatus == ConnectivityResult.none) {
      if (mRepeatQuests
              .where((element) => element.taskIdMix == mTaskIdMix)
              .length !=
          0) return;
      mRepeatQuests.add(QuestRepeatListInfo(
          questMethod: QuestMethod.mix,
          questListInfos: questInfos,
          onMultipleSuccess: onSuccess,
          onError: onError,
          taskIdMix: mTaskIdMix,
          onMultipleFiled: onFiled));
      mNetWorkHandle(_mNetWorkStatus);
      return;
    }
    _showLoading(isShowLoading);
    final List<Future> questList = [];
    try {
      questInfos.forEach((element) {
        if (element.questMethod == QuestMethod.post) {
          questList.add(_mDio.post(element.mapUrl.url,
              options: element.options,
              queryParameters: element.queryParameters,
              data: element.data,
              cancelToken: element.cancelToken));
        } else if (element.questMethod == QuestMethod.get) {
          questList.add(_mDio.get(element.mapUrl.url,
              queryParameters: element.queryParameters,
              options: element.options,
              cancelToken: element.cancelToken));
        }
      });
      final result = await Future.wait(questList);
      if (isShowLoading) {
        EasyLoading.dismiss();
      }
      mRepeatQuests.removeWhere((element) => element.taskIdMix == mTaskIdMix);
      for (int i = 0; i < result.length; i++) {
        final info = TbHttpResult.fromJson(jsonDecode(result[i].toString()));
        if (kDebugMode) {
          log("result-${questInfos[i].mapUrl.taskId}->${result[i]}");
        }
        if (onSuccess != null) {
          if (info.code == mSuccessCode) {
            onSuccess(info.data, questInfos[i].mapUrl.taskId);
          }
        }
        if (onFiled != null) {
          if (info.code != mSuccessCode) {
            onFiled(info.code, info.msg, questInfos[i].mapUrl.taskId);
          }
        } else {
          mErrorCodeHandle(info.code, info.msg, questInfos[i].mapUrl.taskId);
        }
      }
    } on DioError catch (e) {
      _handleError(e, onError, isShowLoading);
    } finally {}
  }

  _showError(DioError e) {
    switch (e.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        {
          Fluttertoast.showToast(
              msg: "internet_time_out".tr,
              backgroundColor: TbSystemConfig.instance.mSnackbarBackground,
              textColor: TbSystemConfig.instance.mSnackbarTextColor);
        }
        break;

      case DioErrorType.response:
        {
          Fluttertoast.showToast(
              msg: "internet_error".tr,
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: TbSystemConfig.instance.mSnackbarBackground,
              textColor: TbSystemConfig.instance.mSnackbarTextColor);
        }
        break;

      case DioErrorType.other:
        {
          Fluttertoast.showToast(
              msg: "internet_unKnow".tr,
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: TbSystemConfig.instance.mSnackbarBackground,
              textColor: TbSystemConfig.instance.mSnackbarTextColor);
        }
        break;
      default:
        {
          Fluttertoast.showToast(
              msg: "internet_unKnow".tr,
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: TbSystemConfig.instance.mSnackbarBackground,
              textColor: TbSystemConfig.instance.mSnackbarTextColor);
        }
        break;
    }
  }

  /*控制是否显示加载进度框*/
  _showLoading(bool isShowLoading) {
    if (isShowLoading) {
      mLoadingView();
    }
  }

  _handleError(DioError e, QuestError? onError, bool isShowLoading) {
    if (isShowLoading) {
      EasyLoading.dismiss();
    }
    mRepeatQuests.clear();
    if (kDebugMode) {
      log("error-->${e.message}");
    }
    if (onError != null) {
      onError(e);
    } else {
      if (mShowErrorMsg) {
        _showError(e);
      }
    }
  }
}
