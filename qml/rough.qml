import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Item {
    width: 100
    height: 50
    anchors.fill: parent
    RowLayout {
        id: row1
        anchors.fill: parent
        spacing: 6
        Rectangle {
            color: "#686868"
            Layout.fillWidth: true
            Layout.fillHeight: true
            TextField {
                opacity: 1
                anchors.fill: parent
                placeholderText: 'Enter location name'
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 14
            }
        }

    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:3}
}
##^##*/
