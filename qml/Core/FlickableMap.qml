import QtQuick 2.12
import "../../js/Database.js" as JS
import "../../js/Core/FlickableMap.js" as FlickableMapScript


Item {

    property alias map_path: mapImg.source
    property alias dynamicRobotListModel: dynamicRobotListModel
    property alias dynamicWayPntListModel: dynamicWayPntListModel
    property bool enable_way_pnts: false
    property real prev_active_mission_id: 0
    property alias mapimg_tap_enabled: tapArea.enabled

    signal createDynamicWayPntItem(real x, real y, string name)
    signal createDynamicRobotItem(real x, real y, string name, bool dynamic)
    signal removeDynamicWayPnt(int way_pnt_ind)
    signal updateNewActiveMissionWayPnts(real new_active_mission_id)
    signal resetAllDynamicItems

    signal dynamicWayPntUpdated
    signal dynamicWayPntCreated

    onCreateDynamicWayPntItem: FlickableMapScript.createDynamicWayPntItem(x, y, "../images/loc.png", name, true)
    onCreateDynamicRobotItem: FlickableMapScript.createDynamicWayPntItem(x, y, "../images/bini.png", name, dynamic)
    onResetAllDynamicItems: FlickableMapScript.resetAllDynamicItems()
    onRemoveDynamicWayPnt: FlickableMapScript.removeDynamicWayPnt(way_pnt_ind)
    onUpdateNewActiveMissionWayPnts: FlickableMapScript.updateNewActiveMissionWayPnts(new_active_mission_id)

    ListModel { id: dynamicRobotListModel }
    ListModel { id: dynamicWayPntListModel }

    Image {
        id: mapImg
        x: (parent.width-width)/2
        y: (parent.height-height)/2
        PinchHandler {}
        DragHandler {}
        TapHandler {
            id: tapArea
            onTapped: FlickableMapScript.mapImgTapped()
        }
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
