
function mapImgTapped() {
    var i = dynamicWayPntListModel.count - 1
    if(enable_way_pnts && sprite.length === 0) {
        createDynamicWayPntItem(tapArea.point.position.x, tapArea.point.position.y, "../images/loc.png", 'Base')
        objCreated()
        enable_way_pnts = false
    }
    else if(enable_way_pnts && sprite.length > 0) {
        createDynamicWayPntItem(tapArea.point.position.x, tapArea.point.position.y, "../images/loc.png", 'Location'+i)
        objCreated()
    }
}

var component;
var sprite = []
var missionWayPnt = []

function createDynamicWayPntItem(x, y, source, name, drag_enabled) {
    component = Qt.createComponent("../qml/Sprite.qml");
    sprite.push(component.createObject(mapImg, {x: x-30, y: y-30, source: source, name: name, drag_enabled: drag_enabled}));

    if (sprite[sprite.length - 1] === null) {
        console.log("Error creating object");
    }
    dynamicWayPntListModel.append({"sprite_item": sprite[sprite.length - 1]})
//    get(count - 1).sprite_item.onPoseChanged.connect(poseChanged)
    dynamicWayPntListModel.get(dynamicWayPntListModel.count-1).sprite_item.onPoseChanged.connect(poseChanged)
}

function createMissionWayPnt(x, y, source, name, drag_enabled) {
    component = Qt.createComponent("../qml/Sprite.qml");
    missionWayPnt.push(component.createObject(mapImg, {x: x-30, y: y-30, source: source, name: name, drag_enabled: drag_enabled}));
    if (missionWayPnt[missionWayPnt.length - 1] === null) {
        // Error Handling
        console.log("Error creating object");
    }
}

function resetAllDynamicItems() {
    for (let i = 0; i < sprite.length; i++) {
      sprite[i].destroy()
    }
    sprite = []
    dynamicRobotListModel.clear()
    dynamicWayPntListModel.clear()
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
        resetMissionWayPnts()
        var wayPntsArray = JS.dbReadMissionWayPnts(new_active_mission_id)
        for (var i = 0; i < wayPntsArray.rows.length; i++) {
            createMissionWayPnt(wayPntsArray.rows.item(i).x, wayPntsArray.rows.item(i).y, "../images/loc.png", wayPntsArray.rows.item(i).name, false)
        }
    }
    prev_active_mission_id = new_active_mission_id
}

function removeDynamicWayPnt(way_pnt_ind) {
    sprite[way_pnt_ind].destroy()
    sprite.splice(way_pnt_ind, 1)
}
