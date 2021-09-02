part of flutter_library;
/*回复网络请求参数配置*/
class QuestRepeatListInfo {
  QuestMethod? questMethod;
  dynamic data;
  Map<String, dynamic>? queryParameters;
  String? url;
  Options? options;
  int? taskId;
  String? taskIdMix ;
  QuestSuccess? onSuccess;
  QuestFailed? onFiled;
  QuestError? onError;

  QuestFailed? onMultipleFiled;
  QuestSuccess? onMultipleSuccess;

  List<QuestListInfo>? questListInfos;

  QuestRepeatListInfo(
      {this.url,
      this.questMethod,
      this.data,
      this.queryParameters,
      this.options,
      this.taskId,
      this.taskIdMix,
      this.onSuccess,
      this.onFiled,
      this.onError,
      this.onMultipleSuccess,
      this.questListInfos,
      this.onMultipleFiled});


}


