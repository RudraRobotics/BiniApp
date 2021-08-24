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
        areaListModel.append({'mission_id': parseInt(mission_id), 'mission_name': missionPlannerTopMenu.areaNameTxt})
        areaListView.currentIndex = -1
        MyJS.resetAll()
    }
    missionPlannerTopMenu.areaNameTxt = ''
}

function  missionPlannerTopMenuWayPntBtnClicked() {
    flickableMap.enable_way_pnts = missionPlannerTopMenu.wayPointBtnEnable
    missionPlannerTopMenu.wayPointBtnHighlighted =! missionPlannerTopMenu.wayPointBtnHighlighted
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
    MyJS.resetAll()
}

function flickableMapWayPntCreated() {
    var i = flickableMap.spriteListModel.count - 1
    if(flickableMap.spriteListModel.count === 1) {
        missionPlannerTopMenu.baseBtnEnable = false
        missionPlannerTopMenu.wayPointBtnEnable = true
        wayPntListModel.append({'name': 'Base', 'x': flickableMap.spriteListModel.get(i).sprite_item.x, 'y':flickableMap.spriteListModel.get(i).sprite_item.y})
    }
    else
        wayPntListModel.append({'name': 'Location'+i, 'x': flickableMap.spriteListModel.get(i).sprite_item.x, 'y':flickableMap.spriteListModel.get(i).sprite_item.y})

    for (let i = 0; i < flickableMap.spriteListModel.count; i++) {
        if(flickableMap.spriteListModel.get(i).sprite_item.acive) {
            wayPntListView.append({'name': 'Location'+i, 'x': flickableMap.spriteListModel.get(i).sprite_item.x, 'y': flickableMap.spriteListModel.get(i).sprite_item.y})
        }
    }

    if(wayPntListModel.count>1)
        missionPlannerTopMenu.saveBtnEnable = true
}

function flickableMapWayPntUpdated()     {
    for (let i = 0; i < flickableMap.spriteListModel.count; i++) {
        if(flickableMap.spriteListModel.get(i).sprite_item.active) {
            wayPntListView.currentIndex = i
            missionPlannerTopMenu.x_pos = flickableMap.spriteListModel.get(i).sprite_item.x
            missionPlannerTopMenu.y_pos = flickableMap.spriteListModel.get(i).sprite_item.y
        }
    }
}
