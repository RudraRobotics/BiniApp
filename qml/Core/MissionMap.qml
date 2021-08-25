import QtQuick 2.12
import "../../js/componentCreation.js" as MyScript
import "../../js/Database.js" as JS


Item {
    property alias map_path: mapImg.source
    property alias dynamicRobotListModel: dynamicRobotListModel
    property bool enable_way_pnts: false
    property real prev_active_mission_id: 0

    ListModel {
        id: dynamicRobotListModel
    }

    signal resetAllDynamicItems
    signal updateNewActiveMissionWayPnts(real new_active_mission_id)

    signal createDynamicRobotItem(real x, real y, string name)
    signal createWayPnts(string name)

    onUpdateNewActiveMissionWayPnts: MyScript.updateNewActiveMissionWayPnts(new_active_mission_id)

    onResetAllDynamicItems: {
        MyScript.resetSpriteObjects()
        dynamicRobotListModel.clear()
    }

    onCreateDynamicRobotItem: {
        MyScript.createSpriteObjects(x, y, "../images/bini.png", name, true)
    }

    onCreateWayPnts: {
        MyScript.createSpriteObjects("../images/bini.png", name, false)
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
