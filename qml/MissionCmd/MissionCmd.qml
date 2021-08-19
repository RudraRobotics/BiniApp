import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQml 2.12
import "../Core"

Item {

    property string default_map: "../../maps/map.pgm"

    MissionCmdTopMenu {
        height: flickableMap.height*0.1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        z: 1
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        anchors.topMargin: 5

    }

    FlickableMap {
        id: flickableMap
        anchors.fill: parent
        map_path: default_map
    }
}
/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:1.33;height:480;width:640}
}
##^##*/
