import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml 2.12
import QtQuick.Layouts 1.12
import "../Core"
import "../"
import "../delegates"

Item {
    width: 640
    height: 480
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
    }}
