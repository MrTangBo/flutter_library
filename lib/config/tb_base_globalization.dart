part of flutter_library;
/*国际化配置*/
class TbBaseGlobalization extends Translations {
  Map<String, Map<String, String>> defaultMap = {
    'zh_CN': {
      'no_internet': '当前网络不可用！',
      'internet_mobile': '当前网络为移动网络！',
      'internet_time_out': '链接超时，请检查网络！',
      'internet_unKnow': '未知错误！',
      'title_tips': '提示',
      'internet_error': '链接出错!',
      'exit_app': '再按一次退出应用!',
    },
    'en_US': {
      'no_internet': 'The current network is unavailable!',
      'internet_mobile': 'The current network is a mobile network！',
      'internet_time_out': 'Link timed out!',
      'internet_unKnow': 'unknown mistake!',
      'title_tips': 'hint',
      'internet_error': 'Link error!',
      'exit_app': 'Press again to exit the app!',
    }
  };

  @override
  Map<String, Map<String, String>> get keys {
    defaultMap.addAll(addMap());
    return defaultMap;
  }

  Map<String, Map<String, String>> addMap() {
    return {};
  }
}
