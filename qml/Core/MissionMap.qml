import QtQuick 2.12
import "../../js/componentCreation.js" as MyScript


Item {

//    property alias x_pos: tapArea.x_pos
//    property alias y_pos: tapArea.y_pos
    property alias map_path: mapImg.source
    property alias posListModel: posListModel
    property bool enable_way_pnts: false

    signal resetItems
    signal objCreated
    signal poseChanged
    signal createSprite(string name)

    onResetItems: {
        MyScript.resetSpriteObjects()
        posListModel.clear()
    }

    onCreateSprite: {
        MyScript.createSpriteObjects(flickableMap.width/2, flickableMap.height/2, "../images/bini.png", name)
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
        source: "../../maps/map1.pgm"
        x: (parent.width-width)/2
        y: (parent.height-height)/2
        PinchHandler {}
        DragHandler {}
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
