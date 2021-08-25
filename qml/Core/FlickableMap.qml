import QtQuick 2.12
import "../../js/componentCreation.js" as MyScript
import "../../js/FlickableMap.js" as JScript


Item {

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
    signal createDynamicWayPntItem(real x, real y, string name)
    signal removeSprite(int index)

    onCreateDynamicWayPntItem: MyScript.createDynamicWayPntItem(x, y, "../images/loc.png", name, true)

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
        x: (parent.width-width)/2
        y: (parent.height-height)/2
        PinchHandler {}
        DragHandler {}
        TapHandler {
            id: tapArea
            onTapped: JScript.mapImgTapped()
        }
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
