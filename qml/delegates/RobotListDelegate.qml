import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQml 2.12

Component {
    Item {
        width: 500; height: 40

        RowLayout {
            id: rowLayout
            anchors.fill: parent
            anchors.bottomMargin: 5
            anchors.topMargin: 5

            Rectangle {
                id: rectangle1
                width: 200
                height: 200
                opacity: 0.7
                color: "#2e64c4"
                radius: 2
                Layout.leftMargin: 10
                Layout.fillHeight: true
                Layout.fillWidth: true

                Text {
                    id: text1
                    text: name
                    anchors.fill: parent
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                }
            }

            Rectangle {
                id: rectangle2
                width: 200
                height: 200
                opacity: 0.7
                color: "#2973b4"
                radius: 2
                Layout.fillHeight: true
                Layout.fillWidth: true

                Text {
                    text: connection
                    anchors.fill: parent
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
            }
        }
    }
}
