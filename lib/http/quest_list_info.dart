part of flutter_library;
/*并行请求参数配置*/

class QuestListInfo {
  QuestMethod? questMethod;
  dynamic data;
  Map<String, dynamic>? queryParameters;
  String? url;
  Options? options;
  int? taskId;

  QuestListInfo(this.url, this.questMethod,
      {this.data, this.queryParameters, this.options, this.taskId});
}

//mix并行请求，
enum QuestMethod { post, get, mix }

