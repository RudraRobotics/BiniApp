var mission_way_pnts = []

function resetAllDynamicItems() {
    for (let i = 0; i < mission_way_pnts.length; i++) {
      mission_way_pnts[i].destroy()
    }
    mission_way_pnts = []
    dynamicRobotListModel.clear()
    dynamicWayPntListModel.clear()
}
/**
* Common method for both mission setup and mission command page
*/
function createDynamicWayPntItem(x, y, source, name, drag_enabled) {
    var component = Qt.createComponent("../qml/Sprite.qml");
    mission_way_pnts.push(component.createObject(mapImg, {x: x-30, y: y-30, source: source, name: name, drag_enabled: drag_enabled}));

    if (mission_way_pnts[mission_way_pnts.length - 1] === null) {
        console.log("Error creating object");
    }
    /* drag is only enabled in in MISSION PLANNING process */
    if(drag_enabled) {
        dynamicWayPntListModel.append({"sprite_item": mission_way_pnts[mission_way_pnts.length - 1]})
        dynamicWayPntListModel.get(dynamicWayPntListModel.count-1).sprite_item.onPoseChanged.connect(dynamicWayPntUpdated)
    }
}

/**
* This method is called when user tapps on map area in MISSION PLANNING phase
*/

function mapImgTapped() {
    var i = dynamicWayPntListModel.count - 1
    if(enable_way_pnts && mission_way_pnts.length === 0) {
        createDynamicWayPntItem(tapArea.point.position.x, tapArea.point.position.y, "../images/loc.png", 'Base', true)
        dynamicWayPntCreated()
        enable_way_pnts = false
    }
    else if(enable_way_pnts && mission_way_pnts.length > 0) {
        createDynamicWayPntItem(tapArea.point.position.x, tapArea.point.position.y, "../images/loc.png", 'Location'+i, true)
        dynamicWayPntCreated()
    }
}

/**
  * This method is called to show the waypoints of mission selected in MISSION COMMAND page
*/

function updateNewActiveMissionWayPnts(new_active_mission_id) {
    if(new_active_mission_id !== prev_active_mission_id) {
        for (var i = 0; i < mission_way_pnts.length; i++)
            mission_way_pnts[i].destroy()
        mission_way_pnts = []
        var wayPntsArray = JS.dbReadMissionWayPnts(new_active_mission_id)
        for (i = 0; i < wayPntsArray.rows.length; i++)
            createDynamicWayPntItem(wayPntsArray.rows.item(i).x, wayPntsArray.rows.item(i).y, "../images/loc.png", wayPntsArray.rows.item(i).name, false)
    }
    prev_active_mission_id = new_active_mission_id
}

/**
* Called from LocListHeaderPoupp to remove given way point from way point list
*/

function removeDynamicWayPnt(way_pnt_ind) {
    mission_way_pnts[way_pnt_ind].destroy()
    mission_way_pnts.splice(way_pnt_ind, 1)
}
