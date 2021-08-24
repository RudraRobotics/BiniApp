import QtQuick 2.12
import QtQml 2.12

Item {
    id: item1
    width: 40
    height: 40
    z: 2
    property alias name: itemTxt.text
    property bool active: dragHandler.active
    property alias source: locIconImg.source
    property alias drag_enabled: dragHandler.enabled

    signal poseChanged
    Image {
        id: locIconImg
        height: parent.height*0.7
        source: "../images/loc.png"
        anchors.bottomMargin: 0
        z: 1
        fillMode: Image.PreserveAspectFit
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
    }
    Component.onCompleted: {
        onXChanged.connect(poseChanged)
        onYChanged.connect(poseChanged)
        //        objCreated
    }

    Text {
        id: itemTxt
        width: 60
        text: qsTr('unknown robot')
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: locIconImg.top
        font.pixelSize: 14
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.NoWrap
        anchors.bottomMargin: 0
        font.bold: true
        clip: false
    }

    DragHandler {
        id: dragHandler
    }


}


