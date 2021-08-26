import QtQuick 2.12
import "../../js/Database.js" as JS
import "../../js/FlickableMap.js" as FlickableMapScript

Item {
    property alias map_path: mapImg.source
    property alias dynamicRobotListModel: dynamicRobotListModel
    property alias dynamicWayPntListModel: dynamicWayPntListModel
    property bool enable_way_pnts: false
    property real prev_active_mission_id: 0
    property alias mapimg_tap_enabled: tapArea.enabled

    signal poseChanged
    signal objCreated

    signal resetAllDynamicItems
    signal updateNewActiveMissionWayPnts(real new_active_mission_id)
    signal createDynamicRobotItem(real x, real y, string name, bool dynamic)
    signal createDynamicWayPntItem(real x, real y,string name, bool dynamic)
    signal removeDynamicWayPnt(int way_pnt_ind)

    onUpdateNewActiveMissionWayPnts: FlickableMapScript.updateNewActiveMissionWayPnts(new_active_mission_id)
    onResetAllDynamicItems: FlickableMapScript.resetAllDynamicItems()
    onCreateDynamicRobotItem: FlickableMapScript.createDynamicWayPntItem(x, y, "../images/bini.png", name, dynamic)
    onCreateDynamicWayPntItem: FlickableMapScript.createDynamicWayPntItem("../images/bini.png", name, dynamic)

    onRemoveDynamicWayPnt: FlickableMapScript.removeDynamicWayPnt(way_pnt_ind)

    ListModel { id: dynamicRobotListModel }
    ListModel { id: dynamicWayPntListModel}

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
