import QtQuick 2.0

Item{
    id: mapItemArea
    clip: true
    Image {
        id: mapImg
        // center the picture here
        x: mapItemArea.width/2-mapImg.width/2
        y: mapItemArea.height/2-mapImg.height/2
        source: "../maps/map.pgm"
                     // Images are loaded asynchronously, only useful for local images
        asynchronous: true
    }
    MouseArea {
        id: mapDragArea
        anchors.fill: mapImg
        drag.target: mapImg
                     // Here, the picture will not be dragged out of the display area whether it is larger or smaller than the display frame
        drag.minimumX: (mapImg.width > mapItemArea.width) ? (mapItemArea.width - mapImg.width) : 0
        drag.minimumY: (mapImg.height > mapItemArea.height) ? (mapItemArea.height - mapImg.height) : 0
        drag.maximumX: (mapImg.width > mapItemArea.width) ? 0 : (mapItemArea.width - mapImg.width)
        drag.maximumY: (mapImg.height > mapItemArea.height) ? 0 : (mapItemArea.height - mapImg.height)

        onWheel: {                                 // Every scroll is a multiple of 120
            var datla = wheel.angleDelta.y/120;
            if(datla > 0)
            {
                mapImg.scale = mapImg.scale/0.9
            }
            else
            {
                mapImg.scale = mapImg.scale*0.9
            }
        }
        onClicked: {
            fnameFieldX.text = mapDragArea.mouseX
            fnameFieldY.text = mapDragArea.mouseY
            fnameFieldX.activeFocus = true
            fnameFieldY.activeFocus = true

        }
    }
}
