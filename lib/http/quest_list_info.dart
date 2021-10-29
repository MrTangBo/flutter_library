part of flutter_library;
/*并行请求参数配置*/

class QuestListInfo {
  QuestMethod? questMethod;
  dynamic data;
  Map<String, dynamic>? queryParameters;
  Map<int, String> mapUrl;
  Options? options;
  CancelToken? cancelToken;

  QuestListInfo(this.mapUrl, this.questMethod,
      {this.data, this.queryParameters, this.options, this.cancelToken});
}

//mix并行请求，
enum QuestMethod { post, get, mix }

enum QuestStatus { error, failed, noInternet, noData, ok }
