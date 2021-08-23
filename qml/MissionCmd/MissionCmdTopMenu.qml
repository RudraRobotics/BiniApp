import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.2
import QtQml 2.12

import "../Database.js" as JS
import "../componentCreation.js" as MyScript
import MqttClient 1.0

Rectangle {
    height: 100
    opacity: 0.7
    color: "#4a4a4a"

    signal resetActiveRobots
    signal resetActiveRobots1

    function find(model, criteria) {
      for(var i = 0; i < model.count; ++i) if (criteria(model.get(i))) return model.get(i)
      return null
    }

    ListModel { id: wayPntListModel }

    function publishData() {
        var data = ''
        wayPntListModel.clear()
        JS.dbReadWayPnts(areaListModel.get(missionComboBox.currentIndex).mission_id)
        for(var i = 0; i < wayPntListModel.count; i++) {
           data += wayPntListModel.get(i).x
           data += '_'
           data += wayPntListModel.get(i).y
           data += '_'
        }
        client.publish(robotComboBox.currentText, data)
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

    onResetActiveRobots: {
        activeRobotListModel.clear()
        MyScript.resetSpriteObjects()
        for(let i=0;i<allActiveMission.count;i++) {
            console.log(areaListModel.get(missionComboBox.currentIndex).mission_id, allActiveMission.get(i).mission_id)
            if(areaListModel.get(missionComboBox.currentIndex).mission_id === allActiveMission.get(i).mission_id) {
                activeRobotListModel.append({'robot_id': allActiveMission.get(i).robot_id, 'name': allActiveMission.get(i).name})
                MyScript.createSpriteObjects1(flickableMap.width/2, flickableMap.height/2+robotComboBox.currentIndex*10)
            }
        }
    }

    onResetActiveRobots1: {
        activeRobotListModel.clear()
        MyScript.resetSpriteObjects()
        for(let i=0;i<allActiveMission.count;i++) {
            console.log(areaListModel.get(missionComboBox.currentIndex).mission_id, allActiveMission.get(i).mission_id)
            if(areaListModel.get(activeAreaListView.currentIndex).mission_id === allActiveMission.get(i).mission_id) {
                activeRobotListModel.append({'robot_id': allActiveMission.get(i).robot_id, 'name': allActiveMission.get(i).name})
                MyScript.createSpriteObjects1(flickableMap.width/2, flickableMap.height/2+robotComboBox.currentIndex*10)
            }
        }
    }

    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        folder: shortcuts.home
        nameFilters: [ "Map files (*.pgm)", "All files (*)" ]
        onAccepted: {
            mapChanged(fileUrl)
            resetItems()
            wayPointBtn.highlighted = false
        }
    }

    ListModel {
        id: areaListModel
        Component.onCompleted: JS.dbReadMissions()
    }

    ListModel {
        id: robotListModel
        Component.onCompleted: JS.dbReadRobots()
    }

    ListModel {
        id: allActiveMission
    }

    RowLayout {
        id: rowLayout
        anchors.fill: parent



        Text {
            id: areaTxt
            color: "#ffffff"
            text: qsTr("Area")
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            Layout.margins: 5
            Layout.fillWidth: true
            Layout.fillHeight: true
        }


        ComboBox {
            id: missionComboBox
            Layout.minimumHeight: 10
            Layout.minimumWidth: 10
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.rightMargin: 5
            Layout.bottomMargin: 5
            Layout.leftMargin: 5
            Layout.topMargin: 5
            textRole: "mission_name"
            model: areaListModel
        }

        Text {
            id: robotTxt
            color: "#ffffff"
            text: qsTr("Robot")
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            Layout.margins: 5
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        ComboBox {
            id: robotComboBox
            Layout.fillWidth: true
            Layout.margins: 5
            Layout.bottomMargin: 5
            Layout.leftMargin: 5
            Layout.topMargin: 5
            Layout.fillHeight: true
            textRole: "name"
            model: robotListModel
        }

        Button {
            id: baseBtn
            text: qsTr("Serve")
            Layout.bottomMargin: 5
            Layout.leftMargin: 5
            Layout.fillWidth: true
            Layout.margins: 5
            Layout.topMargin: 5
            Layout.fillHeight: true
            highlighted: false
            onClicked: {
                if(!find(activeAreaListModel, function(item) { return item.mission_id === areaListModel.get(missionComboBox.currentIndex).mission_id }))
                    activeAreaListModel.append({'mission_id': areaListModel.get(missionComboBox.currentIndex).mission_id, 'mission_name': missionComboBox.currentText})

                if(!find(allActiveMission, function(item) { return item.active_mission === areaListModel.get(missionComboBox.currentIndex).mission_id+'_'+robotListModel.get(robotComboBox.currentIndex).robot_id }))
                {
                    allActiveMission.append({"sprite_item": MyScript.sprite[MyScript.sprite.length - 1], 'active_mission': areaListModel.get(missionComboBox.currentIndex).mission_id+'_'+robotListModel.get(robotComboBox.currentIndex).robot_id,
                                            'mission_id': areaListModel.get(missionComboBox.currentIndex).mission_id, 'robot_id': robotListModel.get(robotComboBox.currentIndex).robot_id,
                                            'name': robotListModel.get(robotComboBox.currentIndex).name})
                    MyScript.createSpriteObjects1(flickableMap.width/2, flickableMap.height/2+robotComboBox.currentIndex*10)
                    activeRobotListModel.append({"sprite_item": MyScript.sprite[MyScript.sprite.length - 1], 'robot_id':robotListModel.get(robotComboBox.currentIndex).robot_id, 'mission_id':areaListModel.get(missionComboBox.currentIndex).mission_id, 'name':robotListModel.get(robotComboBox.currentIndex).name })
                }
                publishData()
                robotListModel.remove(robotListModel.get(robotComboBox.currentIndex))
            }

        }


        Button {
            id: wayPointBtn
            text: qsTr("Return")
            Layout.bottomMargin: 5
            Layout.leftMargin: 5
            Layout.fillWidth: true
            Layout.margins: 5
            Layout.topMargin: 5
            Layout.fillHeight: true
        }

    }
}



