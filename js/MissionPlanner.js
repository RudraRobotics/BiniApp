function resetAll() {
    wayPntListModel.clear()
    flickableMap.resetItems()
    flickableMap.enable_way_pnts = false
}

function areaListViewCurrentIndexChanged() {
    var currentIndex = areaListView.currentIndex
    missionPlannerTopMenu.saveBtnEnable = true
    MyJS.resetAll()
    if(currentIndex>-1) {
        var wayPntListArray = JS.dbReadWayPnts(areaListModel.get(currentIndex).mission_id)
        for (var i = 0; i < wayPntListArray.rows.length; i++) {
            wayPntListModel.append({'waypnt_id': wayPntListArray.rows.item(i).mission_pnt_id, 'name': wayPntListArray.rows.item(i).name, 'x': wayPntListArray.rows.item(i).x, 'y': wayPntListArray.rows.item(i).y})
        }
    }
    // update dynamic objecs in map
    flickableMap.resetItems()
    for(var i=0;i<wayPntListModel.count;i++) {
        flickableMap.createWayPnts(wayPntListModel.get(i).x, wayPntListModel.get(i).y, wayPntListModel.get(i).name)
    }
}

function areaListModelCompleted() {
    var areaListArray = JS.dbReadMissions()
    for (var i = 0; i < areaListArray.rows.length; i++) {
        areaListModel.append({'mission_id': areaListArray.rows.item(i).mission_id, 'mission_name': areaListArray.rows.item(i).name})
    }
}
