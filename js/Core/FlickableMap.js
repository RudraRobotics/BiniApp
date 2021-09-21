var way_pnts_js = []

function resetAllDynamicItems() {
    for (let i = 0; i < way_pnts_js.length; i++) {
      way_pnts_js[i].destroy()
    }
    way_pnts_js = []
    robots.clear()
    way_pnts.clear()
}
/**
* Common method for both mission setup and mission command page
*/
function createDynamicWayPntItem(x, y, source, name, drag_enabled) {
    var component = Qt.createComponent("../../qml/Sprite.qml");
    way_pnts_js.push(component.createObject(mapImg, {x: x-30, y: y-30, source: source, name: name, drag_enabled: drag_enabled}));
    if (way_pnts_js[way_pnts_js.length - 1] === null) {
        console.log("Error creating object");
    }
    /* drag is only enabled in in MISSION PLANNING process */
    if(drag_enabled) {
        way_pnts.append({"sprite_item": way_pnts_js[way_pnts_js.length - 1]})
        way_pnts.get(way_pnts.count-1).sprite_item.onPoseChanged.connect(dynamicWayPntUpdated)
    }
}

/**
* This method is called when user tapps on map area in MISSION PLANNING phase
*/

function mapImgTapped(source) {
    var i = way_pnts.count - 1
    if(enable_way_pnts && way_pnts_js.length === 0) {
        createDynamicWayPntItem(tapArea.point.position.x, tapArea.point.position.y, source, 'Base', true)
        dynamicWayPntCreated()
        enable_way_pnts = false
    }
    else if(enable_way_pnts && way_pnts_js.length > 0) {
        createDynamicWayPntItem(tapArea.point.position.x, tapArea.point.position.y, source, 'Location'+i, true)
        dynamicWayPntCreated()
    }
}

/**
  * This method is called to show the waypoints of mission selected in MISSION COMMAND page
*/

function updateWayPnts(new_active_mission_id, source) {
    if(new_active_mission_id !== prev_active_mission_id) {
        for (var i = 0; i < way_pnts_js.length; i++)
            way_pnts_js[i].destroy()
        way_pnts_js = []
        var wayPntsArray = JS.dbReadMissionWayPnts(new_active_mission_id)
        for (i = 0; i < wayPntsArray.rows.length; i++)
            createDynamicWayPntItem(wayPntsArray.rows.item(i).x, wayPntsArray.rows.item(i).y, source, wayPntsArray.rows.item(i).name, false)
    }
    prev_active_mission_id = new_active_mission_id
}

/**
* Called from LocListHeaderPoupp to remove given way point from way point list
*/

function removeDynamicWayPnt(way_pnt_ind) {
    way_pnts_js[way_pnt_ind].destroy()
    way_pnts_js.splice(way_pnt_ind, 1)
}
