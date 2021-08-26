import QtQuick 2.12
import "../../js/Database.js" as JS
import "../../js/FlickableMap.js" as FlickableMapScript


Item {

    property alias map_path: mapImg.source
    property alias dynamicWayPntListModel: dynamicWayPntListModel
    property bool enable_way_pnts: false
    property alias mapimg_tap_enabled: tapArea.enabled

    signal resetAllDynamicItems
    signal objCreated
    signal poseChanged
    signal createDynamicWayPntItem(real x, real y, string name)
    signal removeDynamicWayPnt(int way_pnt_ind)

    onCreateDynamicWayPntItem: FlickableMapScript.createDynamicWayPntItem(x, y, "../images/loc.png", name, true)

    onResetAllDynamicItems: FlickableMapScript.resetSpriteObjects()

    onRemoveDynamicWayPnt: FlickableMapScript.removeDynamicWayPnt(way_pnt_ind)

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
