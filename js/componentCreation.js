var component;
var sprite = []

function createSpriteObjects(x, y, source, name) {
    component = Qt.createComponent("../qml/Sprite.qml");
    sprite.push(component.createObject(mapImg, {x: x-15, y: y-15, source: source, name: name}));

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
