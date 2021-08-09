import QtQuick 2.12
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
        robot.visible = true
        // robot pose should be in pixel unit
        mqtt_data.x = map_origin.x/0.05 + payload.x/0.05
        mqtt_data.y = map_origin.y/0.05 + payload.y/0.05
//        console.log(mqtt_data)
    }


    Flickable {
        id: mapItemArea
        anchors.fill: parent
        clip: true
        contentWidth: mapImg.width; contentHeight: mapImg.height

        Image {
            id: mapImg
            source: "../maps/map1.pgm";
            scale: 1
            fillMode: Image.PreserveAspectFit;
            PinchHandler { }
            Image {
                id: robot
                x: mqtt_data.x
                y: mapImg.height - mqtt_data.y
                width: 10
                height: 15
                source: "../images/robot.jpg"
                fillMode: Image.PreserveAspectFit
                visible: false
            }
            Image {
                id: robot1
                x: 149
                y: 172
                width: 10
                height: 15
                source: "../images/robot.jpg"
                fillMode: Image.PreserveAspectFit
                visible: false
            }
            Image {
                id: robot3
                x: 157
                y: 163
                width: 10
                height: 15
                source: "../images/robot.jpg"
                fillMode: Image.PreserveAspectFit
                visible: false
            }
        }
        Component.onCompleted: {
            tempSubscription = client.subscribe("bini1_data")
            tempSubscription.messageReceived.connect(addMessage)
        }
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:1.33;height:480;width:640}
}
##^##*/
