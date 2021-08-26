import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml 2.12
import QtQuick.Layouts 1.12
import QtQuick.LocalStorage 2.0

import "../Core"
import "../"
import "../delegates"
import "../../js/Database.js" as JS
import "../../js/MissionPlanner.js" as MyJS

import MqttClient 1.0

Item {
    id: planner

    property string default_map: "../../maps/map.pgm"

    MqttClient {
        property int port_id: 1883
        id: client
        hostname: "localhost"
        port: port_id
        Component.onCompleted: connectToHost()
    }

    ListModel {
        id: missionListModel
        Component.onCompleted: MyJS.getMissionListModelData()
    }

    ListModel {
        id: wayPntListModel
    }

    ListView {
        id: missionListView
        width: planner.width*0.2
        height: 200
        anchors.left: parent.left
        anchors.top: missionPlannerTopMenu.bottom
        spacing: 0
        anchors.leftMargin: 5
        anchors.topMargin: 5
        clip: true
        z: 1
        headerPositioning: ListView.OverlayHeader
        header: MissionListHeader {}
        model: missionListModel
        delegate: MissionListDelegate {}
        highlight: Rectangle { color: "#397ed7"; radius: 5 }
        focus: true
        onCurrentIndexChanged: MyJS.missionListViewCurrentIndexChanged()
    }

    ListView {
        id: wayPntListView
        x: 443
        z: 1
        width: 192
        height: planner.height*0.3
        anchors.right: parent.right
        anchors.top: missionPlannerTopMenu.bottom
        anchors.rightMargin: 5
        anchors.topMargin: 5
        clip: true
        headerPositioning: ListView.OverlayHeader
        header: LocListHeader {}
        delegate: LocListDelegate { id: locListDelegate; textEnabled: flickableMap.enable_way_pnts }
        model: wayPntListModel
        highlight: Rectangle { color: "#397ed7"; radius: 5 }
        focus: true
        onCurrentIndexChanged: missionPlannerTopMenu.saveBtnEnable = true
    }

    MissionPlannerTopMenu {
        id: missionPlannerTopMenu
        height: planner.height*0.1
        opacity: 0.8
        color: "#333333"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        z: 1
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        anchors.topMargin: 5

        onMapChanged: flickableMap.map_path = map_path
        onWayPntBtnClicked: MyJS.missionPlannerTopMenuWayPntBtnClicked()
        onBaseBtnClicked: MyJS.missionPlannerTopMenuBaseBtnClicked()
        onResetBtnClicked: MyJS.missionPlannerTopMenuResetBtnClicked()
        onSaveBtnClicked: MyJS.missionPlannerTopMenuSaveBtnClicked()
    }

    FlickableMap {
        id: flickableMap
        anchors.fill: parent
        map_path: default_map
        mapimg_tap_enabled: true

        onDynamicWayPntCreated: MyJS.flickableMapWayPntCreated()
        onDynamicWayPntUpdated:  MyJS.flickableMapWayPntUpdated()
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.9;height:480;width:640}
}
##^##*/
