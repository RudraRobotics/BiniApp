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
            id: button_back
            height: side_bar.height*0.1
            text: qsTr("Back")
            anchors.left: column.left
            anchors.right: column.right
            anchors.top: parent.top
            anchors.margins: 5
            flat: false
            anchors.topMargin: 5
            onClicked: {
                button_mapping.highlighted = true
                sideBarLoader.source = "MainMenu.qml"
            }
        }
        Button {
            id: button_mapping
            height: side_bar.height*0.1
            text: qsTr("Mapping")
            anchors.left: column.left
            anchors.right: column.right
            anchors.top: button_back.bottom
            anchors.margins: 5
            anchors.topMargin: 5
            onClicked: {
                button_mapping.highlighted = true
                pageLoader.source = "../Mapping.qml"
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
