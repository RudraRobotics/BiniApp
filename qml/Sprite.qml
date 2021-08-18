import QtQuick 2.12
import QtQml 2.12

Image {
    id: locIconImg
    width: 30
    source: "../images/loc.png"
    z: 1
    fillMode: Image.PreserveAspectFit

    property bool active: dragHandler.active

    signal poseChanged

    Component.onCompleted: {
        onXChanged.connect(poseChanged)
        onYChanged.connect(poseChanged)
        objCreated
    }

    DragHandler {
        id: dragHandler
    }
}


