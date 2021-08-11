
class RegexConfig {

  factory RegexConfig()=> _getInstance();

  static RegexConfig? _instance;

  RegexConfig._create();

  static RegexConfig get instance => _getInstance();

  static RegexConfig _getInstance() {
    if (_instance == null) {
      _instance = RegexConfig._create();
    }
    return _instance!;
  }

  static const ORDER_ASC = "asc";
  static const ORDER_DESC = "desc";
  static const SPLIT_SMBOL = ",";

  //列表默认请求条数
  static const PAGE_SIZE = 10;

 //抖动间隔时间，单位 s
  static const JITTER_SPACING_TIME = 1;

 //搜索抖动间隔时间，单位 ms
  static const SEARCH_JITTER_SPACING_TIME = 400;

  //手机号码长度
  static const MOBILE_PHONE_NUMBER_LENGHT = 11;

  //存储相关常量
  // KB 与 Byte 的倍数
  static const KB = 1024;

  //MB 与 Byte 的倍数
  static const MB = 1048576;

  //GB 与 Byte 的倍数
  static const GB = 1073741824;

  //时间相关常量
  //秒与毫秒的倍数
  static const SEC = 1000;

  //分与毫秒的倍数
  static const MIN = 60000;

  //时与毫秒的倍数
  static const HOUR = 3600000;

  //天与毫秒的倍数
  static const DAY = 86400000;

  //正则相关常量
  //正则：手机号（简单）
  static const REGEX_MOBILE_SIMPLE = "^[1]\\d{10}\$";

  /// 正则：手机号（精确）
  ///
  /// 移动：134(0-8)、135、136、137、138、139、147、150、151、152、157、158、159、178、182、183、184、187、188
  ///
  /// 联通：130、131、132、145、155、156、175、176、185、186、166
  ///
  /// 电信：133、153、173、177、180、181、189、199
  ///
  /// 全球星：1349
  ///
  /// 虚拟运营商：170
  static const  REGEX_MOBILE_EXACT  =
      "^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(17[0-9])|(18[0-9])|(19[0-9])|(147)|(16[0-9]))\\d{8}\$";

  /// 正则：电话号码
  static const REGEX_TEL = "^0\\d{2,3}[- ]?\\d{7,8}";

  /// 正则：身份证号码15位
  static const REGEX_ID_CARD15 =
      "^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}\$";

  /// 正则：身份证号码18位
  static const REGEX_ID_CARD18 =
      "^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9Xx])\$";

  //    public static static const String REGEX_ID_CARD18 = "^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$)|(^[1-9]\\d{5}\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{2}$";
  /// 正则：邮箱
  static const REGEX_EMAIL = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$";

  /// 正则：URL
  static const REGEX_URL = "[a-zA-z]+://[^\\s]*";

  /// 正则：汉字
  static const REGEX_ZH_ = "[\\u4e00-\\u9fa5]";

  /// 正则：汉字
  static const REGEX_ZH = "^[\\u4e00-\\u9fa5]+\$";

  /// 正则：用户名，不能以数字开头,不能有emoji
  static const REGEX_USERNAME = "^[a-zA-Z_\\u4e00-\\u9fa5][a-zA-Z0-9_\\u4e00-\\u9fa5]*\$";

  /// 正则：不能以数字开头
  static const REGEX_NOT_NUMBER_START = "^(\\d+)(.*)";

  /// 正则：yyyy-MM-dd格式的日期校验，已考虑平闰年
  static const REGEX_DATE =
      "^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)\$";

  /// 正则：IP地址
  static const REGEX_IP =
      "((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\\.){3}(2[0-4]\\d|25[0-5]|[01]?\\d\\d?)";

  /// 正则：双字节字符(包括汉字在内)
  static const REGEX_DOUBLE_BYTE_CHAR = "[^\\x00-\\xff]";

  /// 正则：空白行
  static const REGEX_BLANK_LINE = "\\n\\s*\\r";

  /// 正则：QQ号
  static const REGEX_TENCENT_NUM = "[1-9][0-9]{4,}";

  /// 正则：中国邮政编码
  static const REGEX_ZIP_CODE = "[1-9]\\d{5}(?!\\d)";

  /// 正则：正整数
  static const REGEX_POSITIVE_INTEGER = "^[1-9]\\d*\$";

  /// 正则：负整数
  static const REGEX_NEGATIVE_INTEGER = "^-[1-9]\\d*\$";

  /// 正则：整数
  static const REGEX_INTEGER = "^-?[1-9]\\d*\$";

  /// 正则：非负整数(正整数 + 0)
  static const REGEX_NOT_NEGATIVE_INTEGER = "^[1-9]\\d*|0\$";

  /// 正则：非正整数（负整数 + 0）
  static const REGEX_NOT_POSITIVE_INTEGER = "^-[1-9]\\d*|0\$";

  /// 正则：正浮点数
  static const REGEX_POSITIVE_FLOAT = "^[1-9]\\d*\\.\\d*|0\\.\\d*[1-9]\\d*\$";

  /// 正则：负浮点数
  static const REGEX_NEGATIVE_FLOAT = "^-[1-9]\\d*\\.\\d*|-0\\.\\d*[1-9]\\d*\$";

  /// 正则：价格 price
  static const REGEX_PRICE = r"^([1-9]\d{0,9}|0)([.]?|(\.\d{1,2})?)$";

  /// 6 到16位包含数字和字母
  static const PASSREGEX = "^(?![0-9]+\$)(?![a-zA-Z]+\$)[0-9A-Za-z]{6,16}\$";


  //正则判断
  bool tbStringCheckRegex(String str,{ String rex = REGEX_MOBILE_EXACT}){

    return  RegExp(rex).hasMatch(str);
  }
  
}

enum MemoryUnit {
  BYTE,
  KB,
  MB,
  GB
}

enum TimeUnit {
  MSEC,
  SEC,
  MIN,
  HOUR,
  DAY
}

