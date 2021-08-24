var component;
var sprite = []
var missionWayPnt = []

function createSpriteObjects(x, y, source, name, drag_enabled) {
    component = Qt.createComponent("../qml/Sprite.qml");
    sprite.push(component.createObject(mapImg, {x: x-30, y: y-30, source: source, name: name, drag_enabled: drag_enabled}));

    if (sprite[sprite.length - 1] == null) {
        // Error Handling
        console.log("Error creating object");
    }
}

function createMissionWayPnt(x, y, source, name, drag_enabled) {
    component = Qt.createComponent("../qml/Sprite.qml");
    missionWayPnt.push(component.createObject(mapImg, {x: x-30, y: y-30, source: source, name: name, drag_enabled: drag_enabled}));
    if (missionWayPnt[missionWayPnt.length - 1] == null) {
        // Error Handling
        console.log("Error creating object");
    }
}

function resetSpriteObjects() {
    for (let i = 0; i < sprite.length; i++) {
      sprite[i].destroy()
    }
    sprite = []
}

function resetMissionWayPnts() {
    for (let i = 0; i < missionWayPnt.length; i++) {
      missionWayPnt[i].destroy()
    }
    missionWayPnt = []
}

function locClicked() {
    posListModel.get(posListModel.active_ind).sprite_item.scale = 1
    posListModel.get(posListModel.active_ind).sprite_item.active = false
    for (let i = 0; i < posListModel.count; i++) {
        if(posListModel.get(i).sprite_item.scale === 2) {
            posListModel.active_ind = i
            posListModel.get(i).sprite_item.active = true
        }
    }
}
