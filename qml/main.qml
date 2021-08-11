import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

import QtQuick.Window 2.12
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtQml 2.12

import Database 1.0
import ListModel 1.0
import MqttClient 1.0

ApplicationWindow {
    id: window
    title: qsTr("BiniApp")
    height: Screen.height
    width: Screen.width
    visible: true

    Material.theme: Material.Dark
    Material.accent: Material.Purple

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
        hostname: "localhost"
        port: port_id
        Component.onCompleted: {
            connectToHost()
        }
    }

    Loader {
        id: sideBarLoader
        width: window.width/4
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        source: "sidebar/MainMenu.qml"
    }

    Loader {
        id: pageLoader
        anchors.left: sideBarLoader.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        source: "Dashboard.qml"
        anchors.leftMargin: 0
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.33;height:480;width:640}
}
##^##*/
