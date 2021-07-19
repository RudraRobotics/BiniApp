import QtQuick 2.0
import QtQuick.Window 2.12
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import org.kde.kirigami 2.10
import MqttClient 1.0

ApplicationWindow {
    id: window
    width: Screen.width
    height: Screen.height
    visible: true

    MqttClient {
        id: mqttClient
    }

//    SideBar {
//        id: rectangle
//        width: window.width * 0.25
//        anchors.left: parent.left
//        anchors.top: parent.top
//        anchors.bottom: parent.bottom
//        anchors.bottomMargin: 0
//        anchors.leftMargin: 0
//        anchors.topMargin: 0
//    }

//    Loader {
//        id: pageLoader
//        anchors.left: rectangle.right
//        anchors.right: parent.right
//        anchors.top: parent.top
//        anchors.bottom: parent.bottom
//        anchors.leftMargin: 0
//        anchors.rightMargin: 0
//        anchors.bottomMargin: 0
//        anchors.topMargin: 0

//        source: "Dashboard.qml"
//    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.33}
}
##^##*/
