part of flutter_library;

abstract class TbBaseState {
  QuestStatus mQuestStatus = QuestStatus.ok;

  late EasyRefreshController mRefreshController;

  init(){
    mRefreshController =EasyRefreshController();
  }

  void dispose() {
    mRefreshController.dispose();
  }
}
