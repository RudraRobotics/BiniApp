function removeWaypnt() {
    var result1 = JS.dbRemoveWayPnt(wayPntListModel.get(wayPntListView.currentIndex).waypnt_id)
    wayPntListModel.remove(wayPntListView.currentIndex)
    flickableMap.dynamicWayPntListModel.get(wayPntListView.currentIndex).sprite_item.destroy()
    flickableMap.dynamicWayPntListModel.remove(wayPntListView.currentIndex)
    popup.close()
    flickableMap.removeDynamicWayPnt(wayPntListView.currentIndex)
}
