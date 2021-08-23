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
        Component.onCompleted: {
            connectToHost()
        }
    }

    ListModel {
        id: areaListModel
        Component.onCompleted: JS.dbReadMissions()
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
            MyJS.resetAll()
            if(currentIndex>-1)
                JS.dbReadWayPnts(areaListModel.get(currentIndex).mission_id)
        }
    }

    ListModel {
        id: wayPntListModel
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
        delegate: LocListDelegate {}
        model: wayPntListModel
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

        onWayPntBtnClicked: {
            flickableMap.enable_way_pnts = wayPointBtnEnable
            wayPointBtnHighlighted =! wayPointBtnHighlighted
        }

        onBaseBtnClicked: {
            baseBtnHighlighted =! baseBtnHighlighted
            areaListView.currentIndex = -1
            flickableMap.enable_way_pnts = true
        }

        onResetBtnClicked: {
            baseBtnEnable = true
            wayPointBtnEnable = false
            baseBtnHighlighted = false
            wayPointBtnHighlighted = false
            saveBtnEnable = false
            areaNameTxt = ''
            areaListView.currentIndex = -1
            MyJS.resetAll()
        }
        onSaveBtnClicked: {
            if(!areaNameTxt.length) {
                areaNameFocus = true
            }
            else {
                baseBtnEnable = true
                wayPointBtnEnable = false
                baseBtnHighlighted = false
                wayPointBtnHighlighted = false
                saveBtnEnable = false
            }
            if(areaNameTxt.length>0 && wayPntListModel.count>0) {
                let mission_id = JS.dbInsertMission(areaNameTxt)
                areaListModel.append({'mission_id': parseInt(mission_id), 'mission_name': areaNameTxt})
                areaListView.currentIndex = -1
                MyJS.resetAll()
            }
            areaNameTxt = ''
        }
    }

    FlickableMap {
        id: flickableMap
        anchors.fill: parent
        map_path: default_map

        onObjCreated: {
            var i = posListModel.count - 1
            if(posListModel.count === 1) {
                missionPlannerTopMenu.baseBtnEnable = false
                missionPlannerTopMenu.wayPointBtnEnable = true
                wayPntListModel.append({'name': 'Base', 'x': posListModel.get(i).sprite_item.x, 'y':posListModel.get(i).sprite_item.y})
            }
            else
                wayPntListModel.append({'name': 'Location'+i, 'x': posListModel.get(i).sprite_item.x, 'y':posListModel.get(i).sprite_item.y})

            for (let i = 0; i < posListModel.count; i++) {
                if(posListModel.get(i).sprite_item.acive) {
                    wayPntListView.append({'name': 'Location'+i, 'x': posListModel.get(i).sprite_item.x, 'y': posListModel.get(i).sprite_item.y})
                }
            }

            if(wayPntListModel.count>1)
                missionPlannerTopMenu.saveBtnEnable = true
        }

        onPoseChanged: {
            for (let i = 0; i < posListModel.count; i++) {
                if(posListModel.get(i).sprite_item.active) {
                    wayPntListView.currentIndex = i
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
