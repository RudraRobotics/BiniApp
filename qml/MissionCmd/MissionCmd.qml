import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQml 2.12
import "../Core"
import "../delegates"

Item {

    property string default_map: "../../maps/map.pgm"

    MissionCmdTopMenu {
        id: missionCmdTopMenu
        height: flickableMap.height*0.1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        z: 1
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        anchors.topMargin: 5

    }

    ListModel {
        id: areaListModel
    }

    ListView {
        id: areaListView
        width: parent.width*0.2
        height: 200
        anchors.left: parent.left
        anchors.top: missionCmdTopMenu.bottom
        spacing: 0
        anchors.leftMargin: 5
        anchors.topMargin: 5
        clip: true
        z: 1
        headerPositioning: ListView.OverlayHeader
        header: MissionListHeader {}
        model: areaListModel
        delegate: MissionListDelegate {}
        highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
        focus: true
        onCurrentIndexChanged: {
            resetAll()
            JS.dbReadWayPnts(areaListModel.get(currentIndex).mission_id)
        }
    }

    ListModel {
        id: robotListModel
    }

    ListView {
        id: wayPntListView
        x: 443
        z: 1
        width: 192
        height: parent.height*0.3
        anchors.right: parent.right
        anchors.top: missionCmdTopMenu.bottom
        anchors.rightMargin: 5
        anchors.topMargin: 5
        clip: true
        headerPositioning: ListView.OverlayHeader
        header: LocListHeader { name: 'Robots' }
        delegate: RobotListDelegate {}
        model: robotListModel
        highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
        focus: true
    }

    FlickableMap {
        id: flickableMap
        anchors.fill: parent
        map_path: default_map
    }
}
/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:1.33;height:480;width:640}
}
##^##*/
