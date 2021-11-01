part of flutter_library;

class TbBottomNavigationState extends TbBaseState {
  PageController mController = PageController();

  List<BottomNavigationBarItem> mBottomTabList = [];
  int mCurrentIndex = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mController.dispose();
  }
}
