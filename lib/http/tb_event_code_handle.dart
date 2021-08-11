
/*错误状态码的处理*/
class TbEvenCodeHandle {

  factory TbEvenCodeHandle() => _getInstance();

  static TbEvenCodeHandle get instance => _getInstance();

  static TbEvenCodeHandle? _instance;

  TbEvenCodeHandle._create();

  static TbEvenCodeHandle _getInstance() {
    if (_instance == null) {
      _instance = TbEvenCodeHandle._create();
    }
    return _instance!;
  }

  Function(dynamic code,dynamic msg) errorCodeHandel =(_,__){};

}
