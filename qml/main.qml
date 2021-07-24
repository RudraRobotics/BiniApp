import QtQuick 2.0
import QtQuick.Window 2.12
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtQml 2.12

import Database 1.0
import ListModel 1.0
import MqttClient 1.0


ApplicationWindow {
    id: window
    width: Screen.width
    height: Screen.height
    visible: true

    // Initializtion of all the custum qml types
    Database {
        id: database
    }
    ListModel {
        id: myModel
    }
    MqttClient {
        property int port_id: 1883
        id: client
        hostname: "192.168.1.94"
        port: port_id
        Component.onCompleted: {
            connectToHost()
        }
    }


    SideBar {
        id: sideBar
        anchors.left: parent.left
        anchors.right: pageLoader.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
    }

    Loader {
        id: pageLoader
        x: 434
        width: 1486
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.topMargin: 0

        source: "Dashboard.qml"
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}
}
##^##*/
