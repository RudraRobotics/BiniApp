var component;
var sprite = []
var missionWayPnt = []

function createSpriteObjects(x, y, source, name, drag_enabled) {
    component = Qt.createComponent("../qml/Sprite.qml");
    sprite.push(component.createObject(mapImg, {x: x-30, y: y-30, source: source, name: name, drag_enabled: drag_enabled}));

    if (sprite[sprite.length - 1] === null) {
        // Error Handling
        console.log("Error creating object");
    }
}

function createMissionWayPnt(x, y, source, name, drag_enabled) {
    component = Qt.createComponent("../qml/Sprite.qml");
    missionWayPnt.push(component.createObject(mapImg, {x: x-30, y: y-30, source: source, name: name, drag_enabled: drag_enabled}));
    if (missionWayPnt[missionWayPnt.length - 1] === null) {
        // Error Handling
        console.log("Error creating object");
    }
}

function resetSpriteObjects() {
    for (let i = 0; i < sprite.length; i++) {
      sprite[i].destroy()
    }
    sprite = []
    dynamicRobotListModel.clear()
}

function resetMissionWayPnts() {
    for (let i = 0; i < missionWayPnt.length; i++) {
      missionWayPnt[i].destroy()
    }
    missionWayPnt = []
}

function locClicked() {
    dynamicRobotListModel.get(dynamicRobotListModel.active_ind).sprite_item.scale = 1
    dynamicRobotListModel.get(dynamicRobotListModel.active_ind).sprite_item.active = false
    for (let i = 0; i < dynamicRobotListModel.count; i++) {
        if(dynamicRobotListModel.get(i).sprite_item.scale === 2) {
            dynamicRobotListModel.active_ind = i
            dynamicRobotListModel.get(i).sprite_item.active = true
        }
    }
}

function updateNewActiveMissionWayPnts(new_active_mission_id) {
    if(new_active_mission_id !== prev_active_mission_id) {
        MyScript.resetMissionWayPnts()
        var wayPntsArray = JS.dbReadMissionWayPnts(new_active_mission_id)
        for (var i = 0; i < wayPntsArray.rows.length; i++) {
            MyScript.createMissionWayPnt(wayPntsArray.rows.item(i).x, wayPntsArray.rows.item(i).y, "../images/loc.png", wayPntsArray.rows.item(i).name, false)
        }
    }
    prev_active_mission_id = new_active_mission_id
}
