import QtQuick 2.0
import QtQml 2.12

Rectangle {
    width: 107
    height: 480

    property string mission: ""

    GridView {
        anchors.fill: parent
        Component {
            id: contactsDelegate

            Rectangle {
                id: rectangleButton
                width: 80
                height: 80
                color: "blue"
                property bool click: false
                Text {
                    id: contactInfo
                    text: nik
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.Wrap
                }
                radius: 5
                MouseArea {
                    id: myMouseId
                    anchors.fill: parent
                    onClicked: {
                        rectangleButton.click = !rectangleButton.click
                        rectangleButton.color = rectangleButton.click ? "red" : "blue"
                        mission += id + "_"
                    }
                }
            }
        }

        model: myModel
        delegate: contactsDelegate
        focus: true
    }
}
