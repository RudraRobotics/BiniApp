import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml 2.12

Item {
    width: 180; height: 40
    z: 2
    Rectangle {
        id: rectangle
        opacity: 0.7
        color: "#0025d9"
        radius: 2
        border.width: 2
        anchors.fill: parent
        anchors.rightMargin: 1
        anchors.leftMargin: 1
        anchors.bottomMargin: 1
        anchors.topMargin: 1

        Text {
            id: textField
            color: "#ffffff"
            text: "Missions"
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 12
        }
        TapHandler {
            onTapped: areaListView.currentIndex = index
        }
    }
}