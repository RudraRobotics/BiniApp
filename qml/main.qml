import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

import QtQuick.Window 2.12
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtQml 2.12

import MqttClient 1.0


ApplicationWindow {
    id: window
    title: qsTr("BiniApp")
    height: Screen.height
    width: screen.width
    visible: true

    Material.theme: Material.Dark
    Material.accent: Material.Purple

    readonly property bool inPortrait: window.width < window.height

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
                            name: "MissionPlanner"
                        }
                        ListElement {
                            name: "MissionCmd"
                        }
                    }

            delegate: ItemDelegate {
                text: name
                width: parent.width
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        font.bold = !font.bold
                        if(index==0)
                            pageLoader.source = "MissionPlanner/MissionPlanner.qml"
                        else if(index==1)
                            pageLoader.source = "MissionCmd.qml"
                    }
                }
            }

            ScrollIndicator.vertical: ScrollIndicator { }
        }
    }

    Loader {
        id: pageLoader
        anchors.fill: parent
        anchors.leftMargin: !inPortrait ? drawer.width : undefined

        source: "MissionPlanner/MissionPlanner.qml"
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.1}
}
##^##*/
