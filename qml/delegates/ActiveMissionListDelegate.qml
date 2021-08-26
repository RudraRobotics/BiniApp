import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml 2.12

Item {
    width: 180; height: 40

    Rectangle {
        id: rectangle
        opacity: 0.7
        color: "#515151"
        radius: 0
        border.width: 2
        anchors.fill: parent
        anchors.rightMargin: 1
        anchors.leftMargin: 1
        anchors.bottomMargin: 1
        anchors.topMargin: 1

        Text {
            id: textField
            color: "#ffffff"
            text: mission_name
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 12
            TapHandler {
                onTapped: activeMissionListView.currentIndex = index
            }
        }
    }
}
