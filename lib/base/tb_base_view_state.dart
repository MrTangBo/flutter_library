part of flutter_library;

abstract class TbBaseViewState {
  QuestStatus mQuestStatus = QuestStatus.ok;

  EasyRefreshController mRefreshController = EasyRefreshController();

  void dispose() {
    mRefreshController.dispose();
  }
}
