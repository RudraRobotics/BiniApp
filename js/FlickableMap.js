
function mapImgTapped() {
    var i = dynamicWayPntListModel.count - 1
    if(enable_way_pnts && MyScript.sprite.length === 0) {
        MyScript.createSpriteObjects(tapArea.point.position.x, tapArea.point.position.y, "../images/loc.png", 'Base')
        dynamicWayPntListModel.append({"sprite_item": MyScript.sprite[MyScript.sprite.length - 1]})
        enable_way_pnts = false
    }
    else if(enable_way_pnts && MyScript.sprite.length > 0) {
        MyScript.createSpriteObjects(tapArea.point.position.x, tapArea.point.position.y, "../images/loc.png", 'Location'+i)
        dynamicWayPntListModel.append({"sprite_item": MyScript.sprite[MyScript.sprite.length - 1]})
    }
    objCreated()
}
