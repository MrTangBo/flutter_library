part of flutter_library;

abstract class TbBaseLogic<T extends TbBaseViewState> extends GetxController {
  bool mIsShowLoading = true;

  int mPage = 1;
  int mPageSize = 15;

  T? mState;

  bool _isLoadMore = false;

  setViewState(T? state) {
    this.mState = state;
  }

  /*下拉刷新*/
  void onRefresh() {
    mPage = 1;
    mIsShowLoading = false;
  }

  /*上拉加载*/
  void onLoadMore() {
    mPage++;
    _isLoadMore = true;
    mIsShowLoading = false;
  }

  /*post请求*/
  post(String url, int taskId,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      QuestSuccess? onSuccess,
      QuestFailed? onFiled,
      QuestError? onError}) async {
    TbHttpUtils.instance.post(url, taskId,
        data: data,
        queryParameters: queryParameters,
        options: options, onSuccess: (result, taskId) {
      resultData(result, taskId);
      update();
    },
        onFiled: failedHandle,
        onError: errorHandle,
        isShowLoading: mIsShowLoading);
  }

  /*get请求*/
  get(String url, int taskId,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      QuestSuccess? onSuccess,
      QuestError? onError,
      QuestFailed? onFiled}) async {
    TbHttpUtils.instance.get(url, taskId,
        queryParameters: queryParameters,
        options: options, onSuccess: (result, taskId) {
      resultData(result, taskId);
      update();
    },
        onFiled: failedHandle,
        onError: errorHandle,
        isShowLoading: mIsShowLoading);
  }

  /*混合请求*/
  questMix(List<QuestListInfo> questInfos,
      {QuestSuccess? onSuccess,
      QuestFailed? onFiled,
      QuestError? onError,bool updateAll =true}) async {
    TbHttpUtils.instance.questMix(questInfos, onSuccess: (result, taskId) {
      resultData(result, taskId);
      if(updateAll){
        update();
      }else{
        update([taskId]);
      }
    },
        onFiled: failedHandle,
        onError: errorHandle,
        isShowLoading: mIsShowLoading);
  }

  /*处理请求数据*/
  resultData(dynamic result, int taskId) {}

  /*处理请求失败*/
  failedHandle(dynamic code, dynamic msg, int taskId) {
    if (_isLoadMore) {
      mPage--;
      _isLoadMore = false;
    }
  }

  /*处理请求错误*/
  errorHandle(dynamic error) {
    if (_isLoadMore) {
      mPage--;
      _isLoadMore = false;
    }
  }
}
