import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml 2.12
import QtQuick.Layouts 1.12
import QtQuick.LocalStorage 2.0

import "../Core"
import "../"
import "../delegates"
import "../Database.js" as JS

import MqttClient 1.0

Item {
    id: planner

    property string default_map: "../../maps/map.pgm"

    function resetAll() {
        locListModel.clear()
        flickableMap.resetItems()
        flickableMap.enable_way_pnts = false
    }

    ListModel {
        id: areaListModel
        Component.onCompleted: JS.dbReadMissions()
    }

    MqttClient {
        property int port_id: 1883
        id: client
        hostname: "localhost"
        port: port_id
        Component.onCompleted: {
            connectToHost()
        }
    }

    ListView {
        id: areaListView
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
        id: locListModel
    }

    ListView {
        id: locListView
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
        delegate: LocListDelegate {}
        model: locListModel
        highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
        focus: true
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

        x_pos: flickableMap.x_pos
        y_pos: flickableMap.y_pos

        // Signal handlers
        onMapChanged: flickableMap.map_path = map_path

        onWayPntBtnClicked: flickableMap.enable_way_pnts = enable_way_pnts
        onBaseBtnClicked: {
            areaListView.currentIndex = -1
            flickableMap.enable_way_pnts = true
        }

        onResetItems: {
            areaListView.currentIndex = -1
            resetAll()
        }
        onSaveBtnClicked: {
            if(areaName.length>0 && locListModel.count>0) {
                var mission_id = JS.dbInsertMission(areaName)
                areaListModel.append({'mission_id': mission_id, 'mission_name': areaName})
                areaListView.currentIndex = -1
                resetAll()
            }
        }
    }

    FlickableMap {
        id: flickableMap
        anchors.fill: parent
        map_path: default_map

        onObjCreated: {
            var i = posListModel.count - 1
            if(posListModel.count === 1) {
                missionPlannerTopMenu.enable_base_btn = false
                missionPlannerTopMenu.enable_waypnt_btn = true
                locListModel.append({'name': 'Base', 'x': posListModel.get(i).sprite_item.x, 'y':posListModel.get(i).sprite_item.y})
            }
            else
                locListModel.append({'name': 'Location'+i, 'x': posListModel.get(i).sprite_item.x, 'y':posListModel.get(i).sprite_item.y})

            for (let i = 0; i < posListModel.count; i++) {
                if(posListModel.get(i).sprite_item.acive) {
                    locListView.append({'name': 'Location'+i, 'x': posListModel.get(i).sprite_item.x, 'y': posListModel.get(i).sprite_item.y})
                }
            }

            if(locListModel.count>1)
                missionPlannerTopMenu.enable_save_btn = true
        }

        onPoseChanged: {
            for (let i = 0; i < posListModel.count; i++) {
                if(posListModel.get(i).sprite_item.active) {
                    locListView.currentIndex = i
                    missionPlannerTopMenu.x_pos = posListModel.get(i).sprite_item.x
                    missionPlannerTopMenu.y_pos = posListModel.get(i).sprite_item.y
                }
            }
        }
    }



}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.9;height:480;width:640}
}
##^##*/
