import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.2
import QtQml 2.12

import "../Database.js" as JS

import MqttClient 1.0

Rectangle {
    height: 100
    opacity: 0.7
    color: "#4a4a4a"

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
        id: robotListModel
        Component.onCompleted: JS.dbReadRobots()
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

        ListModel { id: locListModel }

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



