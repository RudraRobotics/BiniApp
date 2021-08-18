import QtQuick 2.12
import "../componentCreation.js" as MyScript


Item {

    property alias x_pos: tapArea.x_pos
    property alias y_pos: tapArea.y_pos
    property alias map_path: mapImg.source
    property alias posListModel: posListModel
    property bool enable_way_pnts: false

    signal resetItems
    signal objCreated
    signal poseChanged

    onResetItems: {
        MyScript.resetSpriteObjects()
        posListModel.clear()
    }

    ListModel {
        id: posListModel

        property real active_ind: 0

        signal posChanged

        onCountChanged: {
            if(count > 0) {
                objCreated()
                get(count - 1).sprite_item.onPoseChanged.connect(poseChanged)
            }
        }
    }

    Image {
        id: mapImg
        PinchHandler {}
        DragHandler {}
        TapHandler {
            id: tapArea
            property real x_pos: 0.0
            property real y_pos: 0.0
            onTapped: {
                x_pos = point.position.x
                y_pos = point.position.y
                if(enable_way_pnts && MyScript.sprite.length === 0) {
                    MyScript.createSpriteObjects()
                    posListModel.append({"sprite_item": MyScript.sprite[MyScript.sprite.length - 1]})
                    enable_way_pnts = false
                }
                else if(enable_way_pnts && MyScript.sprite.length > 0) {
                    MyScript.createSpriteObjects()
                    posListModel.append({"sprite_item": MyScript.sprite[MyScript.sprite.length - 1]})
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
