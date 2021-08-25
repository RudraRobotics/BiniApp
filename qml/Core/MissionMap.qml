import QtQuick 2.12
import "../../js/componentCreation.js" as MyScript
import "../../js/Database.js" as JS


Item {
    property alias map_path: mapImg.source
    property alias dynamicRobotListModel: dynamicRobotListModel
    property bool enable_way_pnts: false
    property real prev_active_mission_id: 0
    ListModel { id: dynamicRobotListModel }

    signal resetAllDynamicItems
    signal updateNewActiveMissionWayPnts(real new_active_mission_id)
    signal createDynamicRobotItem(real x, real y, string name, bool dynamic)
    signal createDynamicWayPntItem(real x, real y,string name, bool dynamic)

    onUpdateNewActiveMissionWayPnts: MyScript.updateNewActiveMissionWayPnts(new_active_mission_id)
    onResetAllDynamicItems: MyScript.resetSpriteObjects()
    onCreateDynamicRobotItem: MyScript.createSpriteObjects(x, y, "../images/bini.png", name, dynamic)
    onCreateDynamicWayPntItem: MyScript.createSpriteObjects("../images/bini.png", name, dynamic)

    Image {
        id: mapImg
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
