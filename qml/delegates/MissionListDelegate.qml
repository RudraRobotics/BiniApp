import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQml 2.12

Component {
    Item {
        width: 180; height: 40

        Rectangle {
            id: rectangle
            opacity: 0.7
            color: "#515151"
            border.width: 0
            anchors.fill: parent

            TextField {
                id: textField
                text: name
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 12
            }
        }
    }
}
