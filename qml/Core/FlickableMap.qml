import QtQuick 2.12
import "../../js/Database.js" as JS
import "../../js/Core/FlickableMap.js" as FlickableMapScript


Item {

    property alias map_path: mapImg.source
    property alias robots: robots
    property alias way_pnts: way_pnts
    property bool enable_way_pnts: false
    property real prev_active_mission_id: 0
    property alias mapimg_tap_enabled: tapArea.enabled

    signal createDynamicWayPntItem(real x, real y, string name)
    signal createDynamicRobotItem(real x, real y, string name, bool dynamic)
    signal removeDynamicWayPnt(int way_pnt_ind)
    signal updateWayPnts(real new_active_mission_id)
    signal resetAllDynamicItems

    signal dynamicWayPntUpdated
    signal dynamicWayPntCreated

    property var way_pnt_icon: '../../images/loc.png'
    property var robot_icon: '../../images/bini.png'

    onCreateDynamicWayPntItem: FlickableMapScript.createDynamicWayPntItem(x, y, way_pnt_icon, name, true)
    onCreateDynamicRobotItem: FlickableMapScript.createDynamicWayPntItem(x, y, robot_icon, name, dynamic)
    onResetAllDynamicItems: FlickableMapScript.resetAllDynamicItems()
    onRemoveDynamicWayPnt: FlickableMapScript.removeDynamicWayPnt(way_pnt_ind)
    onUpdateWayPnts: FlickableMapScript.updateWayPnts(new_active_mission_id, way_pnt_icon)

    ListModel { id: robots }
    ListModel { id: way_pnts }

    Image {
        id: mapImg
        x: (parent.width-width)/2
        y: (parent.height-height)/2
        PinchHandler {}
        DragHandler {}
        TapHandler {
            id: tapArea
            onTapped: FlickableMapScript.mapImgTapped(way_pnt_icon)
        }
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
