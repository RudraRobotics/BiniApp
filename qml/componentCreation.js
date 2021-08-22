var component;
var sprite = []

function createSpriteObjects() {
    component = Qt.createComponent("Sprite.qml");
    sprite.push(component.createObject(mapImg, {x: x_pos-15, y: y_pos-30}));

    if (sprite[sprite.length - 1] == null) {
        // Error Handling
        console.log("Error creating object");
    }
}

function createSpriteObjects1(x, y) {
    component = Qt.createComponent("Sprite.qml");
    sprite.push(component.createObject(parent, {x: x, y: y}));

    if (sprite[sprite.length - 1] == null) {
        // Error Handling
        console.log("Error creating object");
    }
}

//function destroySpriteObject(ind) {
//    sprite[ind].destroy()
//}

function resetSpriteObjects() {
    for (let i = 0; i < sprite.length; i++) {
      sprite[i].destroy()
    }
    sprite = []
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
