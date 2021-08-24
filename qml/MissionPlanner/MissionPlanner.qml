import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml 2.12
import QtQuick.Layouts 1.12
import QtQuick.LocalStorage 2.0

import "../Core"
import "../"
import "../delegates"
import "../../js/Database.js" as JS
import "../../js/MissionCmd.js" as MyJS

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
        Component.onCompleted: {
            var areaListArray = JS.dbReadMissions()
            for (var i = 0; i < areaListArray.rows.length; i++) {
                areaListModel.append({'mission_id': areaListArray.rows.item(i).mission_id, 'mission_name': areaListArray.rows.item(i).name})
            }
        }
    }

    ListModel {
        id: wayPntListModel
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
        property alias active_index: wayPntListView.active_index
        headerPositioning: ListView.OverlayHeader
        header: MissionListHeader {}
        model: areaListModel
        delegate: MissionListDelegate {
            id: missionListDelegate
            onTapped: console.log('tapped', areaListView.currentIndex)
        }
        highlight: Rectangle { color: "#397ed7"; radius: 5 }
        focus: true
        onCurrentIndexChanged: {
            console.log('active_index', active_index)
            missionPlannerTopMenu.saveBtnEnable = true
            MyJS.resetAll()
            if(currentIndex>-1) {
                var wayPntListArray = JS.dbReadWayPnts(areaListModel.get(currentIndex).mission_id)
                for (var i = 0; i < wayPntListArray.rows.length; i++) {
                    wayPntListModel.append({'waypnt_id': wayPntListArray.rows.item(i).mission_pnt_id, 'name': wayPntListArray.rows.item(i).name, 'x': wayPntListArray.rows.item(i).x, 'y': wayPntListArray.rows.item(i).y})
                }
            }
            // update dynamic objecs in map
            flickableMap.resetItems()
            for(var i=0;i<wayPntListModel.count;i++) {
                flickableMap.createWayPnts(wayPntListModel.get(i).x, wayPntListModel.get(i).y, wayPntListModel.get(i).name)
            }
        }
    }

    ListView {
        id: wayPntListView
        x: 443
        z: 1
        property real active_index: 0
        width: 192
        height: planner.height*0.3
        anchors.right: parent.right
        anchors.top: missionPlannerTopMenu.bottom
        anchors.rightMargin: 5
        anchors.topMargin: 5
        clip: true
        headerPositioning: ListView.OverlayHeader
        header: LocListHeader {}
        delegate: LocListDelegate { id: locListDelegate }
        model: wayPntListModel
        highlight: Rectangle { color: "#397ed7"; radius: 5 }
        focus: true
        onCurrentIndexChanged: {
            missionPlannerTopMenu.saveBtnEnable = true
        }
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
                var wayPntListArray = []
                for(var i=0;i<wayPntListModel.count;i++) {
                    var data = {
                         name: wayPntListModel.get(i).name,
                         x: wayPntListModel.get(i).x,
                         y: wayPntListModel.get(i).y
                     }
                    wayPntListArray.push(data)
                }

                let mission_id = JS.dbInsertMission(areaNameTxt, wayPntListArray)
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
            var i = spriteListModel.count - 1
            if(spriteListModel.count === 1) {
                missionPlannerTopMenu.baseBtnEnable = false
                missionPlannerTopMenu.wayPointBtnEnable = true
                wayPntListModel.append({'name': 'Base', 'x': spriteListModel.get(i).sprite_item.x, 'y':spriteListModel.get(i).sprite_item.y})
            }
            else
                wayPntListModel.append({'name': 'Location'+i, 'x': spriteListModel.get(i).sprite_item.x, 'y':spriteListModel.get(i).sprite_item.y})

            for (let i = 0; i < spriteListModel.count; i++) {
                if(spriteListModel.get(i).sprite_item.acive) {
                    wayPntListView.append({'name': 'Location'+i, 'x': spriteListModel.get(i).sprite_item.x, 'y': spriteListModel.get(i).sprite_item.y})
                }
            }

            if(wayPntListModel.count>1)
                missionPlannerTopMenu.saveBtnEnable = true
        }

        onPoseChanged: {
            console.log('pose changed', spriteListModel.count )
            for (let i = 0; i < spriteListModel.count; i++) {
                if(spriteListModel.get(i).sprite_item.active) {
                    wayPntListView.currentIndex = i
                    missionPlannerTopMenu.x_pos = spriteListModel.get(i).sprite_item.x
                    missionPlannerTopMenu.y_pos = spriteListModel.get(i).sprite_item.y
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
