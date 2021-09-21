function resetAll() {
    all_way_pnts.clear()
    flickableMap.resetAllDynamicItems()
    flickableMap.enable_way_pnts = false
}

function addMessage(robot_name, data)
{
    // Update given robots position
    var robot = find(activeRobotListModel, function(item) { return item.name === robot_name })
    activeRobotListModel.set(robot.robot_id, {"x": data.x, "y": data.y})
}

function find(model, criteria) {
  for(var i = 0; i < model.count; ++i) if (criteria(model.get(i))) return model.get(i)
  return null
}

function updatetAllMapObjects(currentIndex) {
    if(currentIndex>-1) {
        activeRobotListModel.clear()
        flickableMap.resetAllDynamicItems()
        for(var i=0;i<allActiveMission.count;i++) {
            if(missionCmdTopMenu.missionListModel.get(currentIndex).mission_id === allActiveMission.get(i).mission_id) {
                activeRobotListModel.append({
                                                'robot_id': allActiveMission.get(i).robot_id,
                                                'name':     allActiveMission.get(i).name})
                flickableMap.createDynamicWayPntItem(0, 0, allActiveMission.get(i).name, false)
            }
        }

        all_way_pnts.clear()
        flickableMap.updateNewActiveMissionWayPnts(missionCmdTopMenu.missionListModel.get(currentIndex).mission_id)
        var wayPntsArray = JS.dbReadMissionWayPnts(missionCmdTopMenu.missionListModel.get(currentIndex).mission_id)
        for (i = 0; i < wayPntsArray.rows.length; i++) {
            all_way_pnts.append({
                                       'name':  wayPntsArray.rows.item(i).name,
                                       'x':     wayPntsArray.rows.item(i).x,
                                       'y':     wayPntsArray.rows.item(i).y})
        }
        var item = find(all_way_pnts, function(item) { return item.name === 'Base' })
        if(item) {
            for(i=0;i<activeRobotListModel.count;i++) {
                flickableMap.createDynamicRobotItem(item.x, item.y, activeRobotListModel.get(i).name, false)
            }
        }
    }
}

function missionCmdTopMenuServeBtnClicked()
{
    if(missionCmdTopMenu.robotComboBoxCurrentIndex>-1) {

        flickableMap.updateWayPnts(missionCmdTopMenu.missionListModel.get(missionCmdTopMenu.missionComboBoxCurrentIndex).mission_id)
        if(find(all_way_pnts, function(item) { return item.mission_id === missionCmdTopMenu.missionListModel.get(missionCmdTopMenu.missionComboBoxCurrentIndex).mission_id })) {
            way_pnts.append({
                                 'mission_id': missionCmdTopMenu.missionListModel.get(missionCmdTopMenu.missionComboBoxCurrentIndex).mission_id,
                                 'mission_name': missionCmdTopMenu.missionComboBoxCurrentText
                           })
        }

        if(!find(allActiveMission, function(item) { return item.active_mission === missionCmdTopMenu.missionListModel.get(missionCmdTopMenu.missionComboBoxCurrentIndex).mission_id+
                                                    '_'+missionCmdTopMenu.robotListModel.get(missionCmdTopMenu.robotComboBoxCurrentIndex).robot_id }))
        {
            allActiveMission.append({
                                        'active_mission':   missionCmdTopMenu.missionListModel.get(missionCmdTopMenu.robotComboBoxCurrentIndex).mission_id+'_'+missionCmdTopMenu.robotListModel.get(missionCmdTopMenu.robotComboBoxCurrentIndex).robot_id,
                                        'mission_id':       missionCmdTopMenu.missionListModel.get(missionCmdTopMenu.missionComboBoxCurrentIndex).mission_id,
                                        'robot_id':         missionCmdTopMenu.robotListModel.get(missionCmdTopMenu.robotComboBoxCurrentIndex).robot_id,
                                        'name':             missionCmdTopMenu.robotListModel.get(missionCmdTopMenu.robotComboBoxCurrentIndex).name})
            activeRobotListModel.append({
                                            'robot_id':     missionCmdTopMenu.robotListModel.get(missionCmdTopMenu.robotComboBoxCurrentIndex).robot_id,
                                            'mission_id':   missionCmdTopMenu.missionListModel.get(missionCmdTopMenu.missionComboBoxCurrentIndex).mission_id,
                                            'name':         missionCmdTopMenu.robotListModel.get(missionCmdTopMenu.robotComboBoxCurrentIndex).name })
        }
//        var data = ''
//        all_way_pnts.clear()
//        var wayPntsArray = JS.dbReadMissionWayPnts(missionCmdTopMenu.missionListModel.get(missionCmdTopMenu.missionComboBoxCurrentIndex).mission_id)
//        for (var i = 0; i < wayPntsArray.rows.length; i++) {
//            data += wayPntsArray.rows.item(i).x
//            data += '_'
//            data += wayPntsArray.rows.item(i).y
//            data += '_'
//            all_way_pnts.append({
//                                       'name':  wayPntsArray.rows.item(i).name,
//                                       'x':     wayPntsArray.rows.item(i).x,
//                                       'y':     wayPntsArray.rows.item(i).y})
//        }
//        client.publish(missionCmdTopMenu.robotComboBoxCurrentText, data)
//        missionCmdTopMenu.robotListModel.remove(missionCmdTopMenu.robotListModel.get(missionCmdTopMenu.robotComboBoxCurrentIndex))
//        if(missionCmdTopMenu.robotListModel.count===0)
//            missionCmdTopMenu.serveBtnEnabled = false
//        else {
//            var item = MyJS.find(all_way_pnts, function(item) { return item.name === 'Base' })
//            if(item)
//                flickableMap.createDynamicRobotItem(item.x, item.y, missionCmdTopMenu.robotListModel.get(missionCmdTopMenu.robotComboBoxCurrentIndex).name, false)
//        }
    }
}

function missionCmdTopMenuReturnBtnClicked() {
    var item = find(all_way_pnts, function(item) { return item.name === 'Base' })
    if(item) {
        var data = ''
        data += item.x
        data += '_'
        data += item.y
        client.publish(activeRobotListModel.get(activeRobotListView.currentIndex).name, data)
    }
}
