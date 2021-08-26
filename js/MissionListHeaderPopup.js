function removeMission() {
    var result = JS.dbRemoveMission(missionListModel.get(missionListView.currentIndex).mission_id)
    missionListModel.remove(missionListView.currentIndex)
    popup.close()
}
