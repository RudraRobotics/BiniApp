import QtQuick 2.12
import "../../js/componentCreation.js" as MyScript
import "../../js/Database.js" as JS
import "../../js/FlickableMap.js" as JScript

Item {
    property alias map_path: mapImg.source
    property alias dynamicRobotListModel: dynamicRobotListModel
    property alias dynamicWayPntListModel: dynamicWayPntListModel
    property bool enable_way_pnts: false
    property real prev_active_mission_id: 0
    property alias mapimg_tap_enabled: tapArea.enabled
    ListModel { id: dynamicRobotListModel }
    ListModel { id: dynamicWayPntListModel}

    signal poseChanged
    signal objCreated

    signal resetAllDynamicItems
    signal updateNewActiveMissionWayPnts(real new_active_mission_id)
    signal createDynamicRobotItem(real x, real y, string name, bool dynamic)
    signal createDynamicWayPntItem(real x, real y,string name, bool dynamic)
    signal removeSprite(int index)

    onUpdateNewActiveMissionWayPnts: MyScript.updateNewActiveMissionWayPnts(new_active_mission_id)
    onResetAllDynamicItems: MyScript.resetSpriteObjects()
    onCreateDynamicRobotItem: MyScript.createDynamicWayPntItem(x, y, "../images/bini.png", name, dynamic)
    onCreateDynamicWayPntItem: MyScript.createDynamicWayPntItem("../images/bini.png", name, dynamic)

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
