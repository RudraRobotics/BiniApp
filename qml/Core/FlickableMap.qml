import QtQuick 2.12
import "../../js/componentCreation.js" as MyScript


Item {

    property alias x_pos: tapArea.x_pos
    property alias y_pos: tapArea.y_pos
    property alias map_path: mapImg.source
    property alias spriteListModel: spriteListModel
    property bool enable_way_pnts: false
    ListModel {
        id: spriteListModel
        onCountChanged: {
            if(count > 0) {
                objCreated()
                get(count - 1).sprite_item.onPoseChanged.connect(poseChanged)
            }
        }
    }

    signal resetItems
    signal objCreated
    signal poseChanged

    onResetItems: {
        MyScript.resetSpriteObjects()
        spriteListModel.clear()
    }

    Image {
        id: mapImg
        source: "../../maps/map1.pgm"
        x: (parent.width-width)/2
        y: (parent.height-height)/2
        PinchHandler {}
        DragHandler {}
        TapHandler {
            id: tapArea
            property real x_pos: 0.0
            property real y_pos: 0.0
            onTapped: {
                x_pos = point.position.x
                y_pos = point.position.y
                var i = spriteListModel.count - 1
                if(enable_way_pnts && MyScript.sprite.length === 0) {
                    MyScript.createSpriteObjects(x_pos, y_pos, "../images/loc.png", 'Base')
                    spriteListModel.append({"sprite_item": MyScript.sprite[MyScript.sprite.length - 1]})
                    enable_way_pnts = false
                }
                else if(enable_way_pnts && MyScript.sprite.length > 0) {
                    MyScript.createSpriteObjects(x_pos, y_pos, "../images/loc.png", 'Location'+i)
                    spriteListModel.append({"sprite_item": MyScript.sprite[MyScript.sprite.length - 1]})
                }
            }
        }
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
