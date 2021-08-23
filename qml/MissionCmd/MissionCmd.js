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

function resetActiveRobots() {
    activeRobotListModel.clear()
    flickableMap.resetItems()
    for(let i=0;i<allActiveMission.count;i++) {
        if(missionCmdTopMenu.areaListModel.get(missionCmdTopMenu.missionComboBoxCurrentIndex).mission_id === allActiveMission.get(i).mission_id) {
            activeRobotListModel.append({'robot_id': allActiveMission.get(i).robot_id, 'name': allActiveMission.get(i).name})
            flickableMap.createSprite(allActiveMission.get(i).name)
        }
    }
}

function resetActiveRobots1() {
    activeRobotListModel.clear()
    flickableMap.resetItems()
    for(let i=0;i<allActiveMission.count;i++) {
        if(missionCmdTopMenu.areaListModel.get(activeAreaListView.currentIndex).mission_id === allActiveMission.get(i).mission_id) {
            activeRobotListModel.append({'robot_id': allActiveMission.get(i).robot_id, 'name': allActiveMission.get(i).name})
            flickableMap.createSprite(allActiveMission.get(i).name)
        }
    }
}

function clicked()
{
    var missionComboBoxCurrentIndex = missionCmdTopMenu.missionComboBoxCurrentIndex
    var missionComboBoxCurrentText = missionCmdTopMenu.missionComboBoxCurrentText
    var robotComboBoxCurrentIndex = missionCmdTopMenu.robotComboBoxCurrentIndex
    var robotComboBoxCurrentText = missionCmdTopMenu.robotComboBoxCurrentText

    if(!find(activeAreaListModel, function(item) { return item.mission_id === missionCmdTopMenu.areaListModel.get(missionComboBoxCurrentIndex).mission_id }))
        activeAreaListModel.append({'mission_id': missionCmdTopMenu.areaListModel.get(missionComboBoxCurrentIndex).mission_id, 'mission_name': missionComboBoxCurrentText})

    if(!find(allActiveMission, function(item) { return item.active_mission === missionCmdTopMenu.areaListModel.get(missionComboBoxCurrentIndex).mission_id+'_'+missionCmdTopMenu.robotListModel.get(robotComboBoxCurrentIndex).robot_id }))
    {
        allActiveMission.append({'active_mission': missionCmdTopMenu.areaListModel.get(robotComboBoxCurrentIndex).mission_id+'_'+missionCmdTopMenu.robotListModel.get(robotComboBoxCurrentIndex).robot_id,
                                'mission_id': missionCmdTopMenu.areaListModel.get(missionComboBoxCurrentIndex).mission_id, 'robot_id': missionCmdTopMenu.robotListModel.get(robotComboBoxCurrentIndex).robot_id,
                                'name': missionCmdTopMenu.robotListModel.get(robotComboBoxCurrentIndex).name})
        flickableMap.createSprite(missionCmdTopMenu.robotListModel.get(robotComboBoxCurrentIndex).name)
        activeRobotListModel.append({'robot_id':missionCmdTopMenu.robotListModel.get(robotComboBoxCurrentIndex).robot_id, 'mission_id':missionCmdTopMenu.areaListModel.get(missionComboBoxCurrentIndex).mission_id, 'name':missionCmdTopMenu.robotListModel.get(robotComboBoxCurrentIndex).name })
    }
    var data = ''
    wayPntListModel.clear()
    JS.dbReadWayPnts(missionCmdTopMenu.areaListModel.get(missionComboBoxCurrentIndex).mission_id)
    for(var i = 0; i < wayPntListModel.count; i++) {
       data += wayPntListModel.get(i).x
       data += '_'
       data += wayPntListModel.get(i).y
       data += '_'
    }
    client.publish(robotComboBoxCurrentText, data)
    missionCmdTopMenu.robotListModel.remove(missionCmdTopMenu.robotListModel.get(robotComboBoxCurrentIndex))
}

