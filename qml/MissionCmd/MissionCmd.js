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
