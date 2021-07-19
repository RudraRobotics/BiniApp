import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQml 2.3
import QtQuick.Controls 2.3

Item {
    id: item1
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.rightMargin: 0
    anchors.leftMargin: 0
    anchors.bottomMargin: 0
    anchors.topMargin: 0

    GridNavigation {
        id: gridNavigation

        color: "#d8d1d1"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 160
        anchors.leftMargin: 0
        anchors.topMargin: 0
    }

    Button {
        id: button
        text: "SERVE"
        anchors.left: item2.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottomMargin: 430
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.topMargin: 10

        background: Rectangle {
            color: "#ded3d3"
            implicitWidth: 100
            implicitHeight: 40
            border.color: "#26282a"
            border.width: 1
            radius: 5
        }
        onClicked: {
            button.highlighted = !button.highlighted
            pageLoader.source = "Mission.qml"
        }
    }

    Button {
        id: button1
        text: qsTr("RESET")
        anchors.left: item2.right
        anchors.right: parent.right
        anchors.top: button.bottom
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.topMargin: 10

        background: Rectangle {
            color: "#ded3d3"
            implicitWidth: 100
            implicitHeight: 40
            border.color: "#26282a"
            border.width: 1
            radius: 5
        }
        onClicked: {
            button1.highlighted = !button1.highlighted
            rectangleButton.color = "blue"
        }

        Connections {
            target: button1
            onClicked: console.log("clicked")
        }
    }

}


/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:1.33;height:480;width:640}
}
##^##*/
