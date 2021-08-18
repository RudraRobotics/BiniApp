import QtQuick 2.12
import "../componentCreation.js" as MyScript


Flickable {

    contentHeight: mapImg.height
    contentWidth: mapImg.width

    property alias x_pos: mouseArea.mouseX
    property alias y_pos: mouseArea.mouseY
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
                get(count - 1).sprite_item.onLocClicked.connect(MyScript.locClicked)
            }
        }
    }

    Image {
        id: mapImg
        PinchHandler { }
        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: {
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
