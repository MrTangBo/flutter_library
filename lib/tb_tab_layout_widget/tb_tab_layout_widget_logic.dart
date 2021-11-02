part of flutter_library;

class TbTabLayoutWidgetLogic extends TbBaseLogic<TbTabLayoutWidgetState> {


  addTabs(List<Text> Function() tabs) {
    mState!.tabList.addAll(tabs());
    update(["tabLayout"]);
  }

}
