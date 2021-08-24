import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml 2.12

Item {
    width: 180; height: 40
    property alias textEnabled: textInput.enabled
    signal tapped

    Component.onCompleted: tapHandler.tapped.connect(tapped)

    Rectangle {
        id: rectangle
        opacity: 0.7
        color: "#515151"
        radius: 2
        border.width: 2
        anchors.fill: parent
        anchors.rightMargin: 1
        anchors.leftMargin: 1
        anchors.bottomMargin: 1
        anchors.topMargin: 1

        TextInput {
            id: textInput
            text: mission_name
            enabled: false
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

        }

    }
    TapHandler {
        id: tapHandler
        onTapped: {
            areaListView.currentIndex = index
        }
    }
}
