import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQml 2.12
import "../Core"
import "../delegates"
import "../componentCreation.js" as MyScript

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
        id: activeAreaListModel
    }

    ListView {
        id: activeAreaListView
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
        model: activeAreaListModel
        delegate: ActiveMissionListDelegate {}
        highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
        focus: true
        onCountChanged: missionCmdTopMenu.resetActiveRobots()
        onCurrentIndexChanged: missionCmdTopMenu.resetActiveRobots1()
    }

    ListModel {
        id: activeRobotListModel
    }

    ListView {
        id: activeRobotListView
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
        delegate: ActiveRobotListDelegate {}
        model: activeRobotListModel
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
