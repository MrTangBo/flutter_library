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
      'loading': '正在加载..',
      'no_data': '暂无数据~',
      'quest_failed': '请求失败!',
      'refreshedText': '刷新成功',
      'refreshFailedText': '刷新失败',
      'refreshingText': '正在刷新',
      'refreshReadyText': '释放刷新',
      'refreshText': '下拉刷新',
      'infoText': '更新于 %T',
      'loadedText': '加载完成',
      'loadFailedText': '加载失败',
      'loadingText': "正在加载",
      'loadReadyText': "释放加载",
      'loadText': "上拉加载",
    },
    'en_US': {
      'no_internet': 'The current network is unavailable!',
      'internet_mobile': 'The current network is a mobile network！',
      'internet_time_out': 'Link timed out!',
      'internet_unKnow': 'unknown mistake!',
      'title_tips': 'hint',
      'internet_error': 'Link error!',
      'exit_app': 'Press again to exit the app!',
      'loading': 'loading..',
      'no_data': 'no data ~',
      'quest_failed': 'Request failed !',
      'refreshedText': 'Refresh successfully',
      'refreshFailedText': 'Refresh failed',
      'refreshingText': 'Refreshing',
      'refreshReadyText': 'Release refresh',
      'refreshText': 'Pull down to refresh',
      'loadedText': 'Loading completed',
      'loadFailedText': 'Failed to load',
      'loadingText': "loading",
      'loadReadyText': "Release loading",
      'infoText': "update at %T",
      'loadText': "Pull up loading",
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
