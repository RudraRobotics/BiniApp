import QtQuick 2.4
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.4
// This is available in all editors.

Image {
    id: side_bar
    source: "../images/bini.png"
    Column {
        id: column
        anchors.fill: parent
        spacing: 2

        Button {
            id: button_dashboard
            text: qsTr("Dashboard")
            anchors.left: column.left
            anchors.right: column.right
            anchors.top: parent.top
            anchors.margins: 5
            anchors.bottomMargin: 446
            anchors.topMargin: 5
            onClicked: {
                button_dashboard.highlighted = true
                button_mapping.highlighted = false
                button_navigation.highlighted = false
                pageLoader.source = "Dashboard.qml"
            }
            background: Rectangle {
                color: "#ded3d3"
                implicitWidth: 100
                implicitHeight: 40
                border.color: "#26282a"
                border.width: 1
                radius: 5
            }
        }

        Button {
            id: button_mapping
            text: qsTr("Mapping")
            anchors.left: column.left
            anchors.right: column.right
            anchors.top: button_dashboard.bottom
            anchors.margins: 5
            anchors.topMargin: 5
            onClicked: {
                button_dashboard.highlighted = false
                button_mapping.highlighted = true
                button_navigation.highlighted = false
                pageLoader.source = "Mapping.qml"
            }
            background: Rectangle {
                color: "#ded3d3"
                implicitWidth: 100
                implicitHeight: 40
                border.color: "#26282a"
                border.width: 1
                radius: 5
            }
        }

        Button {
            id: button_navigation
            text: qsTr("Navigation")
            anchors.left: column.left
            anchors.right: column.right
            anchors.top: button_mapping.bottom
            anchors.margins: 5
            anchors.topMargin: 5
            onClicked: {
                button_dashboard.highlighted = false
                button_mapping.highlighted = false
                button_navigation.highlighted = true
                pageLoader.source = "Navigation.qml"
            }
            background: Rectangle {
                color: "#ded3d3"
                implicitWidth: 100
                implicitHeight: 40
                border.color: "#26282a"
                border.width: 1
                radius: 5
            }
        }

    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
