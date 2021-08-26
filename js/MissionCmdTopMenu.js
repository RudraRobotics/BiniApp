
function readMissionListModel() {
    var results = JS.dbReadMissions()
    for (var i = 0; i < results.rows.length; i++) {
        missionListModel.append({
                              mission_id: results.rows.item(i).mission_id,
                              mission_name: results.rows.item(i).name
                            })
    }
}

function readRobotListModel() {
    var results = JS.dbReadRobots()
    for (var i = 0; i < results.rows.length; i++) {
        robotListModel.append({
                              robot_id: results.rows.item(i).robot_id,
                              name: results.rows.item(i).name
                            })
    }
}

function fileDialogAccepted() {
    mapChanged(fileUrl)
    resetItems()
    wayPointBtn.highlighted = false
}
