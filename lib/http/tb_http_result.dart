
import 'package:flutter_library/http/tb_http_utils.dart';
class TbHttpResult<T> {
  dynamic code;
  T? data;
  dynamic msg;

  List _jsonKey =TbHttpUtils.instance.jsonKey;

  /*jsonKey有一定的顺序要求code->data->msg*/
  TbHttpResult.fromJson(dynamic json) {
    code = json[_jsonKey[0]];
    data = json[_jsonKey[1]];
    msg = json[_jsonKey[2]];
  }
}
