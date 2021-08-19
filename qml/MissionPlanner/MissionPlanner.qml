import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml 2.12
import QtQuick.Layouts 1.12
import QtQuick.LocalStorage 2.0

import "../Core"
import "../"
import "../delegates"
import "../Database.js" as JS

Item {
    id: planner

    property string default_map: "../../maps/map.pgm"

    ListModel {
        id: locListModel
    }
    Component.onCompleted: {
        JS.dbInit()
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
        model: areaListModel
        delegate: MissionListDelegate {}
        highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
        focus: true
    }

    ListModel {
        id: areaListModel
        Component.onCompleted: JS.dbReadMissions()
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
        Component.onCompleted: resetItems.connect(flickableMap.resetItems)
        onMapChanged: flickableMap.map_path = map_path

        onWayPntBtnClicked: flickableMap.enable_way_pnts = enable_way_pnts
        onBaseBtnClicked: flickableMap.enable_way_pnts = true

        onResetItems: locListModel.clear()

        onSaveBtnClicked: {
            if(areaName.length>0 && locListModel.count>0) {
                JS.dbInsertMission(areaName)
                locListModel.clear()
                flickableMap.resetItems()
                areaName = ''
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
                locListModel.append({'loc_name': 'Base', 'x': posListModel.get(i).sprite_item.x, 'y':posListModel.get(i).sprite_item.y})
            }
            else
                locListModel.append({'loc_name': 'Location'+i, 'x': posListModel.get(i).sprite_item.x, 'y':posListModel.get(i).sprite_item.y})

            for (let i = 0; i < posListModel.count; i++) {
                if(posListModel.get(i).sprite_item.acive) {
                    locListView.append({'loc_name': 'Location'+i, 'x': posListModel.get(i).sprite_item.x, 'y': posListModel.get(i).sprite_item.y})
                }
            }

            if(locListModel.count>1)
                missionPlannerTopMenu.enable_save_btn = true
        }

        onPoseChanged: {
            for (let i = 0; i < posListModel.count; i++) {
                console.log(posListModel.get(i).sprite_item.active, posListModel.get(i).sprite_item.x, posListModel.get(i).sprite_item.y)
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
    D{i:0;autoSize:true;formeditorZoom:0.9;height:480;width:640}D{i:6}
}
##^##*/
