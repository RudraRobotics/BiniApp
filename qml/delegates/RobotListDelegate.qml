import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQml 2.12

Rectangle {
    id: rectangle
    width: 500
    height: 100
    opacity: 0.7
    color: "#515151"
    radius: 2
    border.width: 2
    anchors.fill: parent
    anchors.rightMargin: -265
    anchors.leftMargin: 1
    anchors.bottomMargin: -98
    anchors.topMargin: 1
    TapHandler {
        onTapped: areaListView.currentIndex = index
    }

    RowLayout {
        id: rowLayout
        anchors.fill: parent

        Text {
            id: text1
            text: name
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        Text {
            id: text2
            text: connection
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }
}
