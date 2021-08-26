import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQml 2.12
import "../Core"
import "../delegates"
import MqttClient 1.0
import "../../js/MissionCmd.js" as MyJS

Item {
    property string default_map: "../../maps/map.pgm"
    property var tempSubscription: 0
    ListModel { id: activeWayPntListModel }
    ListModel { id: allActiveMission }
    ListModel { id: activeRobotListModel }
    ListModel { id: wayPntListModel }

    Component.onCompleted: {
        tempSubscription = client.subscribe("bini_data")
        tempSubscription.messageReceived.connect(MyJS.addMessage)
    }

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
        onServeBtnClicked: MyJS.missionCmdTopMenuServeBtnClicked()
        onReturnBtnClicked: MyJS.missionCmdTopMenuReturnBtnClicked()
    }

    ListView {
        id: activeMissionListView
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
        header: MissionListHeader { button_visible: false }
        model: activeWayPntListModel
        delegate: ActiveMissionListDelegate {}
        highlight: Rectangle { color: "#6aabff"; radius: 5 }
        focus: true

        onCurrentIndexChanged: MyJS.updatetAllMapObjects(currentIndex)

        onCountChanged: MyJS.updatetAllMapObjects(count-1)
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
        header: LocListHeader { name: 'Robots'; button_visible: false }
        delegate: ActiveRobotListDelegate {}
        model: activeRobotListModel
        highlight: Rectangle { color: "#6aabff"; radius: 5 }
        focus: true
    }

    MissionMap {
        id: flickableMap
        anchors.fill: parent
        map_path: default_map
        mapimg_tap_enabled: false
    }
}
/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:1.33;height:480;width:640}
}
##^##*/
