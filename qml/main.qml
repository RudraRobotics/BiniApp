import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

import QtQuick.Window 2.12
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtQml 2.12
import "Setup"
import "delegates"
import "../js/Database.js" as JS
import MqttClient 1.0

ApplicationWindow {
    id: window
    title: qsTr("BiniApp")
    height: 800
    width: 1280
    visible: true

    Material.theme: Material.Dark
    Material.accent: Material.Purple

    readonly property bool inPortrait: window.width < window.height

    MqttClient {
        property int port_id: 1883
        id: client
        hostname: "192.168.1.130"
        port: port_id
        Component.onCompleted: {
            connectToHost()
        }
    }

    Drawer {
        id: drawer

        width: window.width * 0.25
        height: window.height

        modal: inPortrait
        interactive: inPortrait
        position: inPortrait ? 0 : 1
        visible: !inPortrait

        ListView {
            id: listView
            anchors.fill: parent

            headerPositioning: ListView.OverlayHeader

            model: ListModel {
                id: sidebarModel
                ListElement {
                    name: "Dashboard"
                }
                ListElement {
                    name: "MissionPlanner"
                }
                ListElement {
                    name: "MissionCmd"
                }
                ListElement {
                    name: "Setup"
                }
            }

            delegate: MenuListDelegate {}

            ScrollIndicator.vertical: ScrollIndicator { }
        }
    }

    Loader {
        id: pageLoader
        anchors.fill: parent
        anchors.leftMargin: !inPortrait ? drawer.width : undefined

        source: "Dashboard.qml"
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.66}
}
##^##*/
