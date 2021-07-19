import QtQuick 2.0

Map {
    id: mapItemArea
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 150
    anchors.rightMargin: 5
    anchors.leftMargin: 0
    anchors.topMargin: 0

    Image {
        id: image
        x: mapItemArea.x + 323
        y: mapItemArea.y + 252
        width: 40
        height: 31
        source: "images/loc.png"
        //        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: image1
        x: mapItemArea.x + 226
        y: mapItemArea.y + 168
        width: 40
        height: 31
        source: "images/loc.png"
    }

    Image {
        id: image2
        x: mapItemArea.x + 205
        y: mapItemArea.y + 242
        width: 40
        height: 31
        source: "images/loc.png"
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:2}D{i:3}
}
##^##*/
