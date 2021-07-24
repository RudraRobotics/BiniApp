import QtQuick 2.4
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.4
// This is available in all editors.

Image {
    id: side_bar
    Column {
        id: column
        anchors.fill: parent
        spacing: 2


        Button {
            id: button_dashboard
            text: qsTr("Home")
            anchors.left: column.left
            anchors.right: column.right
            anchors.top: parent.top
            anchors.margins: 5
            anchors.bottomMargin: 446
            anchors.topMargin: 5
            onClicked: {
                button_dashboard.highlighted = true
                button_setup.highlighted = false
                button_navigation.highlighted = false
                pageLoader.source = "../Dashboard.qml"
            }
        }

        Button {
            id: button_navigation
            text: qsTr("Navigation")
            anchors.left: column.left
            anchors.right: column.right
            anchors.top: button_dashboard.bottom
            anchors.margins: 5
            anchors.topMargin: 5
            onClicked: {
                button_setup.highlighted = false
                button_navigation.highlighted = true
                pageLoader.source = "../Navigation.qml"
            }
        }

        Button {
            id: button_setup
            text: qsTr("Setup")
            anchors.left: column.left
            anchors.right: column.right
            anchors.top: button_navigation.bottom
            anchors.margins: 5
            anchors.bottomMargin: 446
            anchors.topMargin: 5
            onClicked: {
                button_setup.highlighted = true
                button_navigation.highlighted = false
                sideBarLoader.source = "SetupSubMenu.qml"
            }
        }

    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
