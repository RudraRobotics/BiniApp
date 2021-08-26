import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick 2.12

ItemDelegate {
    text: name
    anchors.left: parent.left
    font.pointSize: 14
    anchors.leftMargin: 10
    anchors.rightMargin: 0
    TapHandler {
        onTapped: {
            font.bold = !font.bold
            if(index===0)
                pageLoader.source = "../Dashboard.qml"
            else if(index==1)
                pageLoader.source = "../MissionPlanner/MissionPlanner.qml"
            else if(index==2)
                pageLoader.source = "../MissionCmd/MissionCmd.qml"
            else if(index==3)
                 pageLoader.source = "../Setup/RobotSetup.qml"
        }
    }
}
