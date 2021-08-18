import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml 2.12
import QtQuick.Layouts 1.12
import "../Core"
import "../"


Item {
    id: planner

    property string default_map: "../../maps/map.pgm"

    ListModel {
        id: listModel1
        ListElement {
            name: ""
            x: 0
            y: 0
        }
    }

    Item {
        id: itemDelegate
        width: 100
        height: 50
        anchors.fill: parent
        RowLayout {
            id: row1
            anchors.fill: parent
            spacing: 6
            Rectangle {
                color: "#686868"
                Layout.fillWidth: true
                Layout.fillHeight: true
                TextField {
                    opacity: 1
                    anchors.fill: parent
                    placeholderText: 'Enter location name'
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 14
                }
            }

        }
    }

    ListView {
        id: listView
        width: 100
        height: 200
        anchors.left: parent.left
        anchors.top: missionPlannerTopMenu.bottom
        anchors.leftMargin: 5
        anchors.topMargin: 5
        clip: true
        z: 1
        delegate: itemDelegate
        model: listModel1
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
    }

    FlickableMap {
        id: flickableMap
        anchors.fill: parent
        map_path: default_map

        onObjCreated: {
            if(posListModel.count === 1) {
                missionPlannerTopMenu.enable_base_btn = false
                missionPlannerTopMenu.enable_waypnt_btn = true
            }
            for (let i = 0; i < posListModel.count; i++) {
                if(posListModel.get(i).sprite_item.scale === 2) {
                    listView.append({'name': 'Location'+i, 'x': posListModel.get(i).sprite_item.x, 'y': posListModel.get(i).sprite_item.y})
                }
            }
        }

        onPoseChanged: {
            for (let i = 0; i < posListModel.count; i++) {
                console.log(posListModel.get(i).sprite_item.active, posListModel.get(i).sprite_item.x, posListModel.get(i).sprite_item.y)
                if(posListModel.get(i).sprite_item.active) {
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
