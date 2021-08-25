import QtQuick 2.12
import "../../js/componentCreation.js" as MyScript
import "../../js/FlickableMap.js" as JScript


Item {

    property alias x_pos: tapArea.x_pos
    property alias y_pos: tapArea.y_pos
    property alias map_path: mapImg.source
    property alias dynamicWayPntListModel: dynamicWayPntListModel
    property bool enable_way_pnts: false
    ListModel { id: dynamicRobotListModel }

    ListModel {
        id: dynamicWayPntListModel
        onCountChanged: {
            if(count > 0) {
                get(count - 1).sprite_item.onPoseChanged.connect(poseChanged)
            }
        }
    }

    signal resetItems
    signal objCreated
    signal poseChanged
    signal createWayPnts(real x, real y, string name)
    signal removeSprite(int index)

    onCreateWayPnts: {
        MyScript.createSpriteObjects(x, y, "../images/loc.png", name, true)
        dynamicWayPntListModel.append({"sprite_item": MyScript.sprite[MyScript.sprite.length - 1]})
    }

    onResetItems: {
        MyScript.resetSpriteObjects()
        dynamicWayPntListModel.clear()
    }

    onRemoveSprite: {
        MyScript.sprite[index].destroy()
        MyScript.sprite.splice(index, 1)
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
                var i = dynamicWayPntListModel.count - 1
                if(enable_way_pnts && MyScript.sprite.length === 0) {
                    MyScript.createSpriteObjects(x_pos, y_pos, "../images/loc.png", 'Base')
                    dynamicWayPntListModel.append({"sprite_item": MyScript.sprite[MyScript.sprite.length - 1]})
                    objCreated()
                    enable_way_pnts = false
                }
                else if(enable_way_pnts && MyScript.sprite.length > 0) {
                    MyScript.createSpriteObjects(x_pos, y_pos, "../images/loc.png", 'Location'+i)
                    dynamicWayPntListModel.append({"sprite_item": MyScript.sprite[MyScript.sprite.length - 1]})
                    objCreated()
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
