part of flutter_library;

abstract class TbBaseLogic<T extends TbBaseState> extends GetxController {
  bool mIsShowLoading = true;

  int mPage = 1;
  int mPageSize = 15;

  T? mState;

  bool _isRefresh = false;
  bool _isLoadMore = false;

  CancelToken token = CancelToken();

  setViewState(T? state) {
    this.mState = state;
  }


  /*下拉刷新*/
  void onRefresh() {
    mPage = 1;
    _isRefresh = true;
    _isLoadMore = false;
    mIsShowLoading = false;
    tbRefreshQuest();
  }

  /*上拉加载*/
  void onLoadMore() {
    mPage++;
    _isRefresh = false;
    _isLoadMore = true;
    mIsShowLoading = false;
    tbRefreshQuest();
  }

  void tbRefreshQuest() {}

  /*post请求*/
  post(Map<int,String> mapUrl,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      QuestSuccess? onSuccess,
      QuestFailed? onFiled,
      QuestError? onError}) async {
    TbHttpUtils.instance.post(mapUrl.url, mapUrl.taskId,
        data: data,
        queryParameters: queryParameters,
        token: token,
        options: options, onSuccess: (result, taskId) {
      mState?.mQuestStatus = QuestStatus.ok;
      if (_isLoadMore) {
        mState?.mRefreshController.finishLoad(success: true);
      }
      if (_isRefresh) {
        mState?.mRefreshController.finishRefresh(success: true);
      }
      resultData(result, taskId);
      update();
    },
        onFiled: onFiled ?? failedHandle,
        onError: onError ?? errorHandle,
        isShowLoading: mIsShowLoading);
  }

  /*get请求*/
  get(Map<int,String> mapUrl,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      QuestSuccess? onSuccess,
      QuestError? onError,
      QuestFailed? onFiled}) async {
    TbHttpUtils.instance.get(mapUrl.url, mapUrl.taskId,
        queryParameters: queryParameters,
        token: token,
        options: options, onSuccess: (result, taskId) {
      mState?.mQuestStatus = QuestStatus.ok;
      if (_isLoadMore) {
        mState?.mRefreshController.finishLoad(success: true);
      }
      if (_isRefresh) {
        mState?.mRefreshController.finishRefresh(success: true);
      }
      resultData(result, taskId);
      update();
    },
        onFiled: onFiled ?? failedHandle,
        onError: onError ?? errorHandle,
        isShowLoading: mIsShowLoading);
  }

  /*混合请求*/
  questMix(List<QuestListInfo> questInfos,
      {QuestSuccess? onSuccess,
      QuestFailed? onFiled,
      QuestError? onError,
      bool updateAll = true}) async {
    questInfos.forEach((element) {
      element.cancelToken = token;
    });
    TbHttpUtils.instance.questMix(questInfos, onSuccess: (result, taskId) {
      mState?.mQuestStatus = QuestStatus.ok;
      if (_isLoadMore) {
        mState?.mRefreshController.finishLoad(success: true);
      }
      if (_isRefresh) {
        mState?.mRefreshController.finishRefresh(success: true);
      }
      resultData(result, taskId);
      if (updateAll) {
        update();
      } else {
        update([taskId]);
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
    if (_isLoadMore) {
      mState?.mRefreshController.finishLoad(success: true);
    }
    if (_isRefresh) {
      mState?.mRefreshController.finishRefresh(success: true);
    }
    if (_isLoadMore) {
      mPage--;
    }
    _isLoadMore = false;
    _isRefresh = false;
    update([taskId]);
  }

  /*处理请求错误*/
  errorHandle(dynamic error) {
    if (_isLoadMore) {
      mPage--;
    }
    mState?.mQuestStatus = QuestStatus.error;
    if (_isLoadMore) {
      mState?.mRefreshController.finishLoad(success: true);
    }
    if (_isRefresh) {
      mState?.mRefreshController.finishRefresh(success: true);
    }
    _isLoadMore = false;
    _isRefresh = false;
    update();
  }

  void onBackHome() {}

  void onResume() {
  }

  void onPause() {}

  void onDetach() {}

  @override
  void dispose() {
    mState?.dispose();
    token.cancel();
    super.dispose();
  }
}
