import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQml 2.12

Component {
    Item {
        width: 180; height: 60

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

            TextField {
                id: textField
                color: "#ffffff"
                text: loc_name
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 12
                onPressed: locListView.currentIndex = index
            }
        }
    }
}
