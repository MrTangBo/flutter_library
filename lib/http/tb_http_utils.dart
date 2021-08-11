

import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter_library/config/tb_system_config.dart';
import 'package:flutter_library/http/quest_list_info.dart';
import 'package:flutter_library/http/quest_repeat_list_info.dart';
import 'package:flutter_library/http/tb_http_result.dart';
import 'package:flutter_library/util/tb_log_utils.dart';

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
  Map<String, dynamic> mBaseMultiUrl = {}; //多域名设置
  Map<String, dynamic> mHeader = {};
  List<Interceptor> mInterceptors = []; //自定义拦截器
  Function mLoadingView = () {
    EasyLoading.show(status: "正在加载..", maskType: EasyLoadingMaskType.custom);
  }; //加载进度框
  Transformer mTransformer = DefaultTransformer(); // 自定义 jsonDecodeCallback

  ConnectivityResult _mNetWorkStatus = ConnectivityResult.none; //当前网络状态
  Function(ConnectivityResult mNetWorkStatus) mNetWorkHandle =
      (_) {}; //不同网络状态处理
  bool mFirstIntoApp = true; //是否首次进去app(防止进去App去执行无网络的操作，正常情况应该发起请求时执行)

  Map<String, List<QuestRepeatListInfo>> mRepeatQuestMap = {};

  List<QuestRepeatListInfo> mRepeatQuests = []; //断线重连配置

  bool _isLogQuest = false; //是否已经打印了日志

  bool mShowErrorMsg = true; //是否展示请求超时的或者请求错误弹窗提示;

  QuestFailed mErrorCodeHandle = (_, __, ___) {};

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
            //多域名处理
            options.headers.forEach((key, value) {
              if (mBaseMultiUrl.containsKey(key)) {
                options.baseUrl = mBaseMultiUrl[key];
              }
            });
            if (!_isLogQuest) {
              if (kDebugMode) {
                //debug模式允许打印
                log("realUrl-->${options.baseUrl + options.path}\nqueryParameters-->${jsonEncode(options.queryParameters)}\nformData-->${jsonEncode(options.data)}\nheader-->${options.headers}");
              }
              _isLogQuest = true;
            }
            handler.next(options);
          },
        ),
      );
    //debug模式允许抓包(设置代理)
    if (kDebugMode) {
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
    Connectivity().onConnectivityChanged.listen((result) {
      if (_mNetWorkStatus == result) return;
      _mNetWorkStatus = result;
      if (!mFirstIntoApp) {
        mNetWorkHandle(_mNetWorkStatus);
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
    });
  }

/*单get请求*/
  get(String url, int taskId,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      QuestSuccess? onSuccess,
      QuestError? onError,
      QuestFailed? onFiled,
      bool isShowLoading = true}) async {
    /*无网络不请求*/
    mFirstIntoApp = false;
    if (_mNetWorkStatus == ConnectivityResult.none) {
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
      CancelToken token = CancelToken();
      _showLoading(token, isShowLoading);
      var result = await _mDio.get(url,
          queryParameters: queryParameters,
          options: options,
          cancelToken: token);
      _isLogQuest = false;
      mRepeatQuests.clear();
      if (isShowLoading) {
        EasyLoading.dismiss();
      }
      final info = TbHttpResult.fromJson(jsonDecode(result.toString()));
      if (kDebugMode) {
        log("result-->$result");
        log("body-->${jsonEncode(info.data)}");
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
      bool isShowLoading = true}) async {
    mFirstIntoApp = false;
    /*无网络不请求*/
    if (_mNetWorkStatus == ConnectivityResult.none) {
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
      CancelToken token = CancelToken();
      _showLoading(token, isShowLoading);
      var result = await _mDio.post(url,
          options: options,
          queryParameters: queryParameters,
          data: data,
          cancelToken: token);
      if (isShowLoading) {
        EasyLoading.dismiss();
      }
      _isLogQuest = false;
      mRepeatQuests.clear();
      final info = TbHttpResult.fromJson(jsonDecode(result.toString()));
      if (kDebugMode) {
        log("result-->$result");
        log("body-->${jsonEncode(info.data)}");
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
        mErrorCodeHandle(info.code, info.msg, -1);
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
    if (_mNetWorkStatus == ConnectivityResult.none) {
      mRepeatQuests.add(QuestRepeatListInfo(
          questMethod: QuestMethod.mix,
          questListInfos: questInfos,
          onMultipleSuccess: onSuccess,
          onError: onError,
          onMultipleFiled: onFiled));
      mNetWorkHandle(_mNetWorkStatus);
      return;
    }
    CancelToken token = CancelToken();
    _showLoading(token, isShowLoading);
    final List<Future> questList = [];
    try {
      questInfos.forEach((element) {
        if (element.questMethod == QuestMethod.post) {
          questList.add(_mDio.post(element.url!,
              options: element.options,
              queryParameters: element.queryParameters,
              data: element.data,
              cancelToken: token));
        } else if (element.questMethod == QuestMethod.get) {
          questList.add(_mDio.get(element.url!,
              queryParameters: element.queryParameters,
              options: element.options,
              cancelToken: token));
        }
      });
      final result = await Future.wait(questList);
      _isLogQuest = false;
      mRepeatQuests.clear();
      if (isShowLoading) {
        EasyLoading.dismiss();
      }
      for (int i = 0; i < result.length; i++) {
        final info = TbHttpResult.fromJson(jsonDecode(result[i].toString()));
        if (kDebugMode) {
          log("result-->$result");
          log("body-->${jsonEncode(info.data)}");
        }
        if (onSuccess != null) {
          if (info.code == mSuccessCode) {
            onSuccess(info.data, questInfos[i].taskId!);
          }
        }
        if (onFiled != null) {
          if (info.code != mSuccessCode) {
            onFiled(info.code, info.msg, questInfos[i].taskId!);
          }
        } else {
          mErrorCodeHandle(info.code, info.msg, questInfos[i].taskId!);
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
          Get.snackbar("title_tips".tr, "internet_time_out".tr,
              backgroundColor: TbSystemConfig.instance.mSnackbarBackground,
              colorText: TbSystemConfig.instance.mSnackbarTextColor);
        }
        break;

      case DioErrorType.response:
        {
          Get.snackbar("title_tips".tr, "internet_error".tr,
              backgroundColor: TbSystemConfig.instance.mSnackbarBackground,
              colorText: TbSystemConfig.instance.mSnackbarTextColor);
        }
        break;

      case DioErrorType.other:
        {
          Get.snackbar("title_tips".tr, "internet_unKnow".tr,
              backgroundColor: TbSystemConfig.instance.mSnackbarBackground,
              colorText: TbSystemConfig.instance.mSnackbarTextColor);
        }
        break;
      default:
        {
          Get.snackbar("title_tips".tr, "internet_unKnow".tr,
              backgroundColor: TbSystemConfig.instance.mSnackbarBackground,
              colorText: TbSystemConfig.instance.mSnackbarTextColor);
        }
        break;
    }
  }

  /*控制是否显示加载进度框*/
  _showLoading(CancelToken token, bool isShowLoading) {
    if (isShowLoading) {
      mLoadingView();
    }
  }

  _handleError(DioError e, QuestError? onError, bool isShowLoading) {
    if (isShowLoading) {
      EasyLoading.dismiss();
    }
    _isLogQuest = false;
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


