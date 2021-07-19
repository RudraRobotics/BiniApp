import QtQuick 2.0

Rectangle {
    height: 480

    GridView {
        anchors.fill: parent
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.bottomMargin: 10
        anchors.topMargin: 10
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
                    }
                }
            }
        }

        model: myModel
        delegate: contactsDelegate
        focus: true
    }
}
