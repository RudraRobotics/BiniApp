import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml 2.12

Item {
    property alias button_visible: button.visible

    width: 180; height: 40
    z: 2
    Rectangle {
        id: rectangle
        opacity: 0.7
        color: "#0025d9"
        radius: 0
        border.width: 2
        anchors.fill: parent
        anchors.rightMargin: 1
        anchors.leftMargin: 1
        anchors.bottomMargin: 1
        anchors.topMargin: 1

        Text {
            id: textField
            width: rectangle.width*0.8
            color: "#ffffff"
            text: "Missions"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 12
        }

        Button {
            id: button
            text: qsTr("Option")
            anchors.left: textField.right
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            z: 0
            anchors.leftMargin: 5
            anchors.rightMargin: 5
            anchors.bottomMargin: 0
            anchors.topMargin: 0
            onClicked: popup.open()
        }
        Popup {
            id: popup
            padding: 10

            contentItem: MissionListHeaderPopup {}
        }
    }
}
