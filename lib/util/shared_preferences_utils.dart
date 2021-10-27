part of flutter_library;

/*本地持久化数据存储工具*/
class SharedPreferencesUtils {
  static final clearKeyData = [];

  /*存数据  isClear默认存储的都是可清除的*/
  static savePreference<T>(String key, T value, {bool isClear = true}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isSave = false;
    if (value is int) {
      isSave = await prefs.setInt(key, value);
    } else if (value is double) {
      isSave = await prefs.setDouble(key, value);
    } else if (value is bool) {
      isSave = await prefs.setBool(key, value);
    } else if (value is String) {
      isSave = await prefs.setString(key, value);
    } else if (value is List<String>) {
      isSave = await prefs.setStringList(key, value);
    } else {
      throw new Exception("不能得到这种类型");
    }
    if (isSave && !clearKeyData.contains(key) && isClear) {
      clearKeyData.add(key);
    }
  }

  /*取数据*/
  static Future getPreference<T>(String key, T defaultValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (defaultValue is int) {
      return prefs.getInt(key) ?? Future.value(defaultValue);
    } else if (defaultValue is double) {
      return prefs.getDouble(key) ?? Future.value(defaultValue);
    } else if (defaultValue is bool) {
      return prefs.getBool(key) ?? Future.value(defaultValue);
    } else if (defaultValue is String) {
      return prefs.getString(key) ?? defaultValue;
    } else if (defaultValue is List) {
      return prefs.getStringList(key) ?? Future.value(defaultValue);
    } else {
      throw new Exception("不能得到这种类型");
    }
  }

  /*删除指定数据*/
  static void remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key); //删除指定键
  }

  /*清空可清除的缓存*/
  static void clearCan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    clearKeyData.forEach((element) {
      prefs.remove(element);
    });
  }

  /*清空整个缓存*/
  static void clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear(); ////清空缓存
  }
}
