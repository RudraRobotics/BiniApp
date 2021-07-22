import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQml 2.12


Item {
    id: mission
    anchors.fill: parent

    property var tempSubscription: 0
    property point mqtt_data: "1000, 1000"
    property point map_origin: "10.0, 10.0"

    function addMessage(payload)
    {
        // robot pose should be in pixel unit
        mqtt_data.x = map_origin.x/0.05 + payload.x/0.05
        mqtt_data.y = map_origin.y/0.05 + payload.y/0.05
    }

    Item{
        id: mapItemArea
        anchors.bottomMargin: 0
        clip: true
        property point origin: "30, 42"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        Image {
            id: mapImg
            x: mapItemArea.width/2-mapImg.width/2
            y: mapItemArea.height/2-mapImg.height/2
            z: 1
            source: "../maps/map.pgm"
            asynchronous: true

            Image {
                id: robot
                x: mqtt_data.x
                y: mqtt_data.y
                width: 10
                height: 15
                source: "../images/robot.jpg"
                fillMode: Image.PreserveAspectFit
            }
            Image {
                id: robot1
                x: 149
                y: 172
                width: 10
                height: 15
                source: "../images/robot.jpg"
                fillMode: Image.PreserveAspectFit
            }
            Image {
                id: robot3
                x: 157
                y: 163
                width: 10
                height: 15
                source: "../images/robot.jpg"
                fillMode: Image.PreserveAspectFit
            }
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
                var datla = wheel.angleDelta.y/120
                if(datla > 0)
                {
                    mapImg.scale = mapImg.scale/0.9
                }
                else
                {
                    mapImg.scale = mapImg.scale*0.9
                }
            }
        }
        Component.onCompleted: {
            tempSubscription = client.subscribe("bini1")
            tempSubscription.messageReceived.connect(addMessage)
        }
    }

    Text {
        id: pose_txt
        text:  "pose:"+ mqtt_data
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        font.pixelSize: 12
        anchors.rightMargin: 429
        anchors.leftMargin: 8
        anchors.bottomMargin: 13
        anchors.topMargin: 448
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:1.66;height:480;width:640}D{i:7}
}
##^##*/
