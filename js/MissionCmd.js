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

function updatetMapObjects(currentIndex) {
    activeRobotListModel.clear()
    flickableMap.resetItems()
    for(let i=0;i<allActiveMission.count;i++) {
        if(missionCmdTopMenu.missionListModel.get(currentIndex).mission_id === allActiveMission.get(i).mission_id) {
            activeRobotListModel.append({'robot_id': allActiveMission.get(i).robot_id, 'name': allActiveMission.get(i).name})
            flickableMap.createWayPnts(allActiveMission.get(i).name)
        }
    }

    wayPntListModel.clear()
    flickableMap.updateActiveMission(missionCmdTopMenu.missionListModel.get(currentIndex).mission_id)
    var wayPntsArray = JS.dbReadWayPnts(missionCmdTopMenu.missionListModel.get(currentIndex).mission_id)
    for (var i = 0; i < wayPntsArray.rows.length; i++) {
        wayPntListModel.append({'name': wayPntsArray.rows.item(i).name, 'x': wayPntsArray.rows.item(i).x, 'y': wayPntsArray.rows.item(i).y})
    }
    var item = find(wayPntListModel, function(item) { return item.name === 'Base' })
    if(item) {
        for(var i=0;i<activeRobotListModel.count;i++) {
            flickableMap.createRobot(item.x, item.y, activeRobotListModel.get(i).name)
        }
    }
}

function serveBtnClicked()
{
    console.log('save clicked')
    var missionComboBoxCurrentIndex = missionCmdTopMenu.missionComboBoxCurrentIndex
    var missionComboBoxCurrentText = missionCmdTopMenu.missionComboBoxCurrentText
    var robotComboBoxCurrentIndex = missionCmdTopMenu.robotComboBoxCurrentIndex
    var robotComboBoxCurrentText = missionCmdTopMenu.robotComboBoxCurrentText
    if(robotComboBoxCurrentIndex>-1) {

        flickableMap.updateActiveMission(missionCmdTopMenu.missionListModel.get(missionComboBoxCurrentIndex).mission_id)

        if(!find(activeWayPntListModel, function(item) { return item.mission_id === missionCmdTopMenu.missionListModel.get(missionComboBoxCurrentIndex).mission_id }))
            activeWayPntListModel.append({'mission_id': missionCmdTopMenu.missionListModel.get(missionComboBoxCurrentIndex).mission_id, 'mission_name': missionComboBoxCurrentText})

        if(!find(allActiveMission, function(item) { return item.active_mission === missionCmdTopMenu.missionListModel.get(missionComboBoxCurrentIndex).mission_id+'_'+missionCmdTopMenu.robotListModel.get(robotComboBoxCurrentIndex).robot_id }))
        {
            allActiveMission.append({'active_mission': missionCmdTopMenu.missionListModel.get(robotComboBoxCurrentIndex).mission_id+'_'+missionCmdTopMenu.robotListModel.get(robotComboBoxCurrentIndex).robot_id,
                                    'mission_id': missionCmdTopMenu.missionListModel.get(missionComboBoxCurrentIndex).mission_id, 'robot_id': missionCmdTopMenu.robotListModel.get(robotComboBoxCurrentIndex).robot_id,
                                    'name': missionCmdTopMenu.robotListModel.get(robotComboBoxCurrentIndex).name})
    //        flickableMap.createSprite(missionCmdTopMenu.robotListModel.get(robotComboBoxCurrentIndex).name)
            activeRobotListModel.append({'robot_id':missionCmdTopMenu.robotListModel.get(robotComboBoxCurrentIndex).robot_id, 'mission_id':missionCmdTopMenu.missionListModel.get(missionComboBoxCurrentIndex).mission_id, 'name':missionCmdTopMenu.robotListModel.get(robotComboBoxCurrentIndex).name })
        }
        var data = ''
        wayPntListModel.clear()
        var wayPntsArray = JS.dbReadWayPnts(missionCmdTopMenu.missionListModel.get(missionComboBoxCurrentIndex).mission_id)
        for (var i = 0; i < wayPntsArray.rows.length; i++) {
            data += wayPntsArray.rows.item(i).x
            data += '_'
            data += wayPntsArray.rows.item(i).y
            data += '_'
            wayPntListModel.append({'name': wayPntsArray.rows.item(i).name, 'x': wayPntsArray.rows.item(i).x, 'y': wayPntsArray.rows.item(i).y})
        }
        client.publish(robotComboBoxCurrentText, data)
        missionCmdTopMenu.robotListModel.remove(missionCmdTopMenu.robotListModel.get(robotComboBoxCurrentIndex))
        if(missionCmdTopMenu.robotListModel.count===0)
            missionCmdTopMenu.serveBtnEnabled = false
        else {
            var item = MyJS.find(wayPntListModel, function(item) { return item.name === 'Base' })
            console.log('item:', wayPntListModel.count)
            if(item)
                flickableMap.createRobot(item.x, item.y, missionCmdTopMenu.robotListModel.get(robotComboBoxCurrentIndex).name)
        }
    }
}

