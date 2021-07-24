import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQml 2.12


Item {
    id: mission
    anchors.fill: parent

    property var tempSubscription: 0
    property point mqtt_data: "1000, 1000"
    property point map_origin: "10.0, 10"
    property string map_path: "../maps/map1.pgm"

    function addMessage(payload)
    {
        // robot pose should be in pixel unit
        mqtt_data.x = map_origin.x/0.05 + payload.x/0.05
        mqtt_data.y = map_origin.y/0.05 + payload.y/0.05
//        console.log(mqtt_data)
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

            source: map_path
            scale: 2
            fillMode: Image.PreserveAspectCrop
            asynchronous: true

            Image {
                id: robot
                x: mqtt_data.x
                y: mapImg.height - mqtt_data.y
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

        Text {
            id: text2
            x: 511
            y: 55
            text: qsTr("Battery status: 24 V")
            font.pixelSize: 12
        }
        Component.onCompleted: {
            tempSubscription = client.subscribe("bini1_data")
            tempSubscription.messageReceived.connect(addMessage)
        }
    }

    Text {
        id: text1
        x: -73
        y: -88
        text: qsTr("Bini_1")
        font.pixelSize: 12
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:1.33;height:480;width:640}
}
##^##*/
