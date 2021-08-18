import QtQuick 2.12
import QtQml 2.12

Image {
    id: locIconImg
    width: 30
    source: "../images/loc.png"
    z: 1
    fillMode: Image.PreserveAspectFit

    property bool active: false
    property alias scale: locIconImg.scale

    signal poseChanged
    signal locClicked

    Component.onCompleted: {
        onXChanged.connect(poseChanged)
        onYChanged.connect(poseChanged)
        mouseArea.clicked.connect(locClicked)
        objCreated
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        drag.target: parent

        hoverEnabled: true

        onClicked: {
            if(locIconImg.scale == 1) {
                locIconImg.scale = 2
                active = true
            }
            else {
                locIconImg.scale = 1
                active = false
            }
        }
    }
}


