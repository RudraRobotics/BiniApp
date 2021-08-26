function resetAll() {
    wayPntListModel.clear()
    flickableMap.resetAllDynamicItems()
    flickableMap.enable_way_pnts = false
}

function areaListViewCurrentIndexChanged() {
    var currentIndex = areaListView.currentIndex
    missionPlannerTopMenu.saveBtnEnable = true
    resetAll()
    if(currentIndex>-1) {
        var wayPntListArray = JS.dbReadMissionWayPnts(areaListModel.get(currentIndex).mission_id)
        for (var i = 0; i < wayPntListArray.rows.length; i++) {
            wayPntListModel.append({
                                       'waypnt_id': wayPntListArray.rows.item(i).mission_pnt_id,
                                       'name':      wayPntListArray.rows.item(i).name,
                                       'x':         wayPntListArray.rows.item(i).x,
                                       'y':         wayPntListArray.rows.item(i).y
                                   })
        }
    }
    // update dynamic objecs in map
    flickableMap.resetAllDynamicItems()
    for(i=0;i<wayPntListModel.count;i++) {
        flickableMap.createDynamicWayPntItem(wayPntListModel.get(i).x, wayPntListModel.get(i).y, wayPntListModel.get(i).name, true)
    }
}

function getAreaListModelData() {
    var areaListArray = JS.dbReadMissions()
    for (var i = 0; i < areaListArray.rows.length; i++) {
        areaListModel.append({
                                 'mission_id':   areaListArray.rows.item(i).mission_id,
                                 'mission_name': areaListArray.rows.item(i).name
                             })
    }
}

function missionPlannerTopMenuSaveBtnClicked()  {

    if(!missionPlannerTopMenu.areaNameTxt.length) {
        missionPlannerTopMenu.areaNameFocus = true
    }
    else {
        missionPlannerTopMenu.baseBtnEnable = true
        missionPlannerTopMenu.wayPointBtnEnable = false
        missionPlannerTopMenu.baseBtnHighlighted = false
        missionPlannerTopMenu.wayPointBtnHighlighted = false
        missionPlannerTopMenu.saveBtnEnable = false
    }
    if(missionPlannerTopMenu.areaNameTxt.length>0 && wayPntListModel.count>0) {
        var wayPntListArray = []
        for(var i=0;i<wayPntListModel.count;i++) {
            var data = {name: wayPntListModel.get(i).name, x: wayPntListModel.get(i).x, y: wayPntListModel.get(i).y}
            wayPntListArray.push(data)
        }

        let mission_id = JS.dbInsertMission(missionPlannerTopMenu.areaNameTxt, wayPntListArray)
        areaListModel.append({
                                 'mission_id':   parseInt(mission_id),
                                 'mission_name': missionPlannerTopMenu.areaNameTxt
                             })
        areaListView.currentIndex = -1
        resetAll()
    }
    missionPlannerTopMenu.areaNameTxt = ''
}

function  missionPlannerTopMenuWayPntBtnClicked() {
    missionPlannerTopMenu.wayPointBtnHighlighted =! missionPlannerTopMenu.wayPointBtnHighlighted
    flickableMap.enable_way_pnts = missionPlannerTopMenu.wayPointBtnHighlighted
}

function missionPlannerTopMenuBaseBtnClicked() {
    missionPlannerTopMenu.baseBtnHighlighted =! missionPlannerTopMenu.baseBtnHighlighted
    areaListView.currentIndex = -1
    flickableMap.enable_way_pnts = true
}

function missionPlannerTopMenuResetBtnClicked() {
    missionPlannerTopMenu.baseBtnEnable = true
    missionPlannerTopMenu.wayPointBtnEnable = false
    missionPlannerTopMenu.baseBtnHighlighted = false
    missionPlannerTopMenu.wayPointBtnHighlighted = false
    missionPlannerTopMenu.saveBtnEnable = false
    missionPlannerTopMenu.areaNameTxt = ''
    areaListView.currentIndex = -1
    resetAll()
}

function flickableMapWayPntCreated() {
    var i = flickableMap.dynamicWayPntListModel.count - 1
    if(flickableMap.dynamicWayPntListModel.count === 1) {
        missionPlannerTopMenu.baseBtnEnable = false
        missionPlannerTopMenu.wayPointBtnEnable = true
        wayPntListModel.append({
                                   'name':  'Base',
                                   'x':     flickableMap.dynamicWayPntListModel.get(i).sprite_item.x,
                                   'y':     flickableMap.dynamicWayPntListModel.get(i).sprite_item.y
                               })
    }
    else
        wayPntListModel.append({
                                   'name':  'Location'+i,
                                   'x':     flickableMap.dynamicWayPntListModel.get(i).sprite_item.x,
                                   'y':     flickableMap.dynamicWayPntListModel.get(i).sprite_item.y
                               })
    for (let i = 0; i < flickableMap.dynamicWayPntListModel.count; i++) {
        if(flickableMap.dynamicWayPntListModel.get(i).sprite_item.acive) {
            wayPntListView.append({
                                      'name':   'Location'+i,
                                      'x':      flickableMap.dynamicWayPntListModel.get(i).sprite_item.x,
                                      'y':      flickableMap.dynamicWayPntListModel.get(i).sprite_item.y
                                  })
        }
    }

    if(wayPntListModel.count>1)
        missionPlannerTopMenu.saveBtnEnable = true
}

function flickableMapWayPntUpdated()     {
    for (let i = 0; i < flickableMap.dynamicWayPntListModel.count; i++) {
        if(flickableMap.dynamicWayPntListModel.get(i).sprite_item.active) {
            wayPntListView.currentIndex = i
            missionPlannerTopMenu.x_pos = flickableMap.dynamicWayPntListModel.get(i).sprite_item.x
            missionPlannerTopMenu.y_pos = flickableMap.dynamicWayPntListModel.get(i).sprite_item.y
        }
    }
}
