import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml 2.12
import QtQuick.Layouts 1.12
import "../Core"
import "../"
import "../delegates"
import DataBase 1.0

Item {
    id: planner

    property string default_map: "../../maps/map.pgm"

    ListModel { id: listModel1 }

    DataBase { id: dataBase }

    ListView {
        id: listView
        width: planner.width*0.2
        height: 200
        anchors.left: parent.left
        anchors.top: missionPlannerTopMenu.bottom
        spacing: 0
        anchors.leftMargin: 5
        anchors.topMargin: 5
        clip: true
        z: 1
        delegate: MissionListDelegate {}
        model: listModel1
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

        onResetItems: listModel1.clear()

        onSaveBtnClicked: {
            if(listModel1.count) {
                console.log('save')
//                dataBase.inserIntoTable()
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
                listModel1.append({'name': 'Base', 'x': posListModel.get(i).sprite_item.x, 'y':posListModel.get(i).sprite_item.y})
            }
            else
                listModel1.append({'name': 'Location'+i, 'x': posListModel.get(i).sprite_item.x, 'y':posListModel.get(i).sprite_item.y})

            for (let i = 0; i < posListModel.count; i++) {
                if(posListModel.get(i).sprite_item.acive) {
                    listView.append({'name': 'Location'+i, 'x': posListModel.get(i).sprite_item.x, 'y': posListModel.get(i).sprite_item.y})
                }
            }

            if(listModel1.count>1)
                missionPlannerTopMenu.enable_save_btn = true
        }

        onPoseChanged: {
            for (let i = 0; i < posListModel.count; i++) {
                console.log(posListModel.get(i).sprite_item.active, posListModel.get(i).sprite_item.x, posListModel.get(i).sprite_item.y)
                if(posListModel.get(i).sprite_item.active) {
                    listView.currentIndex = i
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
