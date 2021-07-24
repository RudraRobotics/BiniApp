import QtQuick 2.0
import QtQuick.Window 2.12
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3

Item {
    id: contactsDelegate
    Rectangle {
        id: wrapper

        property bool isBlue: true
        width: 80
        height: 80
        color: isBlue ? "blue" : "red"
        Text {
            id: contactInfo
            text: name
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: "white"
        }
        radius: 5
        MouseArea {
            anchors.fill: wrapper
            onClicked: {
                wrapper.isBlue = !wrapper.isBlue
            }
        }
    }
}
