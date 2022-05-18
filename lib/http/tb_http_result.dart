part of flutter_library;
class TbHttpResult<T> {
  dynamic code;
  T? data;
  dynamic msg;

  List _jsonKey =TbHttpUtils.instance.jsonKey;


  TbHttpResult(this.code, this.data, this.msg);

  /*jsonKey有一定的顺序要求code->data->msg*/
  TbHttpResult.fromJson(dynamic json) {
    code = json[_jsonKey[0]];
    data = json[_jsonKey[1]];
    msg = json[_jsonKey[2]];
  }
}
