import QtQuick 2.12
import QtQml 2.12

Item {
    id: item1
    width: 90
    height: 70
    property alias name: itemTxt.text
    property bool active: dragHandler.active
    property alias source: locIconImg.source

    signal poseChanged
    Image {
        id: locIconImg
        height: parent.height*0.8
        source: "../images/loc.png"
        anchors.bottomMargin: 0
        z: 1
        fillMode: Image.PreserveAspectFit
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
    }

    Rectangle {
        id: rectangle
        opacity: 0.8
        color: "#0024d0"
        radius: 2
        border.width: 2
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: locIconImg.top
        anchors.bottomMargin: 0
        anchors.topMargin: 0

        Text {
            id: itemTxt
            text: qsTr('unknown robot')
            anchors.fill: parent
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
    Component.onCompleted: {
        onXChanged.connect(poseChanged)
        onYChanged.connect(poseChanged)
        //        objCreated
    }

    DragHandler {
        id: dragHandler
    }

}


