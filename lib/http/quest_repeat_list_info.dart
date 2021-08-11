
/*回复网络请求参数配置*/
import 'package:dio/dio.dart';
import 'package:flutter_library/http/quest_list_info.dart';
import 'package:flutter_library/http/tb_http_utils.dart';

class QuestRepeatListInfo {
  QuestMethod? questMethod;
  dynamic data;
  Map<String, dynamic>? queryParameters;
  String? url;
  Options? options;
  int? taskId;

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
      this.onSuccess,
      this.onFiled,
      this.onError,
      this.onMultipleSuccess,
      this.questListInfos,
      this.onMultipleFiled});
}


