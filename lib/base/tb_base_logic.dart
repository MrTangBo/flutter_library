part of flutter_library;

abstract class TbBaseLogic<T extends TbBaseState> extends GetxController {
  bool mIsShowLoading = true;

  int mPage = 1;
  int mPageSize = 15;

  T? mState;
  String? mLogicTag;

  bool isRefresh = false;
  bool isLoadMore = false;

  CancelToken token = CancelToken();

  setViewState(T? state) {
    this.mState = state;
  }

  /*下拉刷新*/
  void onRefresh() {
    mPage = 1;
    isRefresh = true;
    isLoadMore = false;
    mIsShowLoading = false;
    tbRefreshQuest();
  }

  /*上拉加载*/
  void onLoadMore() {
    mPage++;
    isRefresh = false;
    isLoadMore = true;
    mIsShowLoading = false;
    tbRefreshQuest();
  }

  void tbRefreshQuest() {}

  /*post请求*/
  post(Map<int, String> mapUrl, {dynamic data, Map<String, dynamic>? queryParameters, Options? options, QuestSuccess? onSuccess, QuestFailed? onFiled, QuestError? onError}) async {
    TbHttpUtils.instance.post(mapUrl.url, mapUrl.taskId,
        data: data,
        queryParameters: queryParameters,
        token: token,
        options: options,
        onSuccess: onSuccess ??
            (result, taskId) {
              mState?.mQuestStatus = QuestStatus.ok;
              resultData(result, taskId);
              update();
              if (isLoadMore) {
                mState?.mRefreshController.finishLoad(success: true);
              }
              if (isRefresh) {
                mState?.mRefreshController.finishRefresh(success: true);
              }
            },
        onFiled: onFiled ?? failedHandle,
        onError: onError ?? errorHandle,
        isShowLoading: mIsShowLoading);
  }

  /*get请求*/
  get(Map<int, String> mapUrl, {Map<String, dynamic>? queryParameters, Options? options, QuestSuccess? onSuccess, QuestError? onError, QuestFailed? onFiled}) async {
    TbHttpUtils.instance.get(mapUrl.url, mapUrl.taskId,
        queryParameters: queryParameters,
        token: token,
        options: options,
        onSuccess: onSuccess ??
            (result, taskId) {
              mState?.mQuestStatus = QuestStatus.ok;
              resultData(result, taskId);
              update();
              if (isLoadMore) {
                mState?.mRefreshController.finishLoad(success: true);
              }
              if (isRefresh) {
                mState?.mRefreshController.finishRefresh(success: true);
              }
            },
        onFiled: onFiled ?? failedHandle,
        onError: onError ?? errorHandle,
        isShowLoading: mIsShowLoading);
  }

  /*混合请求*/
  questMix(List<QuestListInfo> questInfos, {QuestSuccess? onSuccess, QuestFailed? onFiled, QuestError? onError, bool updateAll = true}) async {
    questInfos.forEach((element) {
      element.cancelToken = token;
    });
    TbHttpUtils.instance.questMix(questInfos,
        onSuccess: onSuccess ??
            (result, taskId) {
              mState?.mQuestStatus = QuestStatus.ok;
              resultData(result, taskId);
              if (updateAll) {
                update();
              } else {
                update([taskId]);
              }
              if (isLoadMore) {
                mState?.mRefreshController.finishLoad(success: true);
              }
              if (isRefresh) {
                mState?.mRefreshController.finishRefresh(success: true);
              }
            },
        onFiled: onFiled ?? failedHandle,
        onError: onError ?? errorHandle,
        isShowLoading: mIsShowLoading);
  }

  /*处理请求数据*/
  resultData(dynamic result, int taskId) {}

  /*处理请求失败*/
  failedHandle(dynamic code, dynamic msg, int taskId) {
    mState?.mQuestStatus = QuestStatus.failed;
    if (isLoadMore) {
      mPage--;
    }
    isLoadMore = false;
    isRefresh = false;
    update([taskId]);
    if (isLoadMore) {
      mState?.mRefreshController.finishLoad(success: false);
    }
    if (isRefresh) {
      mState?.mRefreshController.finishRefresh(success: false);
    }
  }

  /*处理请求错误*/
  errorHandle(dynamic error) {
    if (isLoadMore) {
      mPage--;
    }
    mState?.mQuestStatus = QuestStatus.error;
    isLoadMore = false;
    isRefresh = false;
    update();
    if (isLoadMore) {
      mState?.mRefreshController.finishLoad(success: false);
    }
    if (isRefresh) {
      mState?.mRefreshController.finishRefresh(success: false);
    }
  }

  void onBackHome() {}

  void onResume() {}

  void onPause() {}

  void onDetach() {}

  @override
  void dispose() {
    mState?.dispose();
    token.cancel();
    super.dispose();
  }
}
