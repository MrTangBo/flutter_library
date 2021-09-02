part of flutter_library;

abstract class TbBaseViewState {
  QuestStatus mQuestStatus = QuestStatus.ok;

  late EasyRefreshController mRefreshController;

  void dispose() {
    mRefreshController.dispose();
  }
}
