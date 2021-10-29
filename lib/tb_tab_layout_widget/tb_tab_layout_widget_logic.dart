part of flutter_library;

class TbTabLayoutWidgetLogic extends TbBaseLogic<TbTabLayoutWidgetState> {

  static TbTabLayoutWidgetLogic getLoic() => Get.find<TbTabLayoutWidgetLogic>();

  addTabs(List<Text> tabs) {
    mState!.tabList.addAll(tabs);
    update(["tabLayout"]);
  }
}
