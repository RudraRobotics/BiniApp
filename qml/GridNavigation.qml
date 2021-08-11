import QtQuick 2.0
import QtQml 2.12

Rectangle {
    width: 107
    height: 480
    property point pose: '0, 0'
    GridView {
        id: gridItem
        anchors.fill: parent

        model: myModel
        delegate: Rectangle {
            id: rectangleButton
            width: 80
            height: 80
            color: "blue"
            property bool click: false
            anchors.margins: 10
            Text {
                text: nik
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.Wrap
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    rectangleButton.click = !rectangleButton.click
                    rectangleButton.color = rectangleButton.click ? "red" : "blue"
                    pose.x = fname
                    pose.y = sname
                    mission.push(pose)
                }
            }
        }
    }
}
