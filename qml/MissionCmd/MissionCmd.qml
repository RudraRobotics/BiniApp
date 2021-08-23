import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQml 2.12
import "../Core"
import "../delegates"
import MqttClient 1.0
import "../Database.js" as JS


Item {

    // ############################################################################ //
    property string default_map: "../../maps/map.pgm"
    property var tempSubscription: 0

    ListModel { id: activeAreaListModel }
    ListModel { id: allActiveMission }
    ListModel { id: activeRobotListModel }
    ListModel { id: wayPntListModel }

    // ############################################################################## //
    function addMessage(robot_name, data)
    {
        // Update given robots position
        var robot = find(activeRobotListModel, function(item) { return item.name === robot_name })
        activeRobotListModel.set(robot.robot_id, {"x": data.x, "y": data.y})
    }

    function find(model, criteria) {
      for(var i = 0; i < model.count; ++i) if (criteria(model.get(i))) return model.get(i)
      return null
    }

    function resetActiveRobots() {
        activeRobotListModel.clear()
        flickableMap.resetItems()
        for(let i=0;i<allActiveMission.count;i++) {
            if(missionCmdTopMenu.areaListModel.get(missionCmdTopMenu.missionComboBoxCurrentIndex).mission_id === allActiveMission.get(i).mission_id) {
                activeRobotListModel.append({'robot_id': allActiveMission.get(i).robot_id, 'name': allActiveMission.get(i).name})
                flickableMap.createSprite(flickableMap.width/2, flickableMap.height/2)
            }
        }
    }

    function resetActiveRobots1() {
        activeRobotListModel.clear()
        flickableMap.resetItems()
        for(let i=0;i<allActiveMission.count;i++) {
            if(missionCmdTopMenu.areaListModel.get(activeAreaListView.currentIndex).mission_id === allActiveMission.get(i).mission_id) {
                activeRobotListModel.append({'robot_id': allActiveMission.get(i).robot_id, 'name': allActiveMission.get(i).name})
                flickableMap.createSprite(flickableMap.width/2, flickableMap.height/2)
            }
        }
    }

    // ############################################################################# //

    Component.onCompleted: {
        tempSubscription = client.subscribe("bini_data")
        tempSubscription.messageReceived.connect(addMessage)
        console.log('bini_data mqtt topic subscribed')
    }

    // ############################################################################# //

    MissionCmdTopMenu {
        id: missionCmdTopMenu
        height: flickableMap.height*0.1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        z: 1
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        anchors.topMargin: 5
        onClicked: {
            if(!find(activeAreaListModel, function(item) { return item.mission_id === areaListModel.get(missionComboBoxCurrentIndex).mission_id }))
                activeAreaListModel.append({'mission_id': areaListModel.get(missionComboBoxCurrentIndex).mission_id, 'mission_name': missionComboBoxCurrentText})

            if(!find(allActiveMission, function(item) { return item.active_mission === areaListModel.get(missionComboBoxCurrentIndex).mission_id+'_'+robotListModel.get(robotComboBoxCurrentIndex).robot_id }))
            {
                console.log(robotComboBoxCurrentIndex, areaListModel.get(robotComboBoxCurrentIndex).mission_id)
                allActiveMission.append({'active_mission': areaListModel.get(robotComboBoxCurrentIndex).mission_id+'_'+robotListModel.get(robotComboBoxCurrentIndex).robot_id,
                                        'mission_id': areaListModel.get(missionComboBoxCurrentIndex).mission_id, 'robot_id': robotListModel.get(robotComboBoxCurrentIndex).robot_id,
                                        'name': robotListModel.get(robotComboBoxCurrentIndex).name})
                flickableMap.createSprite()
                activeRobotListModel.append({'robot_id':robotListModel.get(robotComboBoxCurrentIndex).robot_id, 'mission_id':areaListModel.get(missionComboBoxCurrentIndex).mission_id, 'name':robotListModel.get(robotComboBoxCurrentIndex).name })
            }
            var data = ''
            wayPntListModel.clear()
            JS.dbReadWayPnts(areaListModel.get(missionComboBoxCurrentIndex).mission_id)
            for(var i = 0; i < wayPntListModel.count; i++) {
               data += wayPntListModel.get(i).x
               data += '_'
               data += wayPntListModel.get(i).y
               data += '_'
            }
            client.publish(robotComboBoxCurrentText, data)
            robotListModel.remove(robotListModel.get(robotComboBoxCurrentIndex))
        }
    }

    ListView {
        id: activeAreaListView
        width: parent.width*0.2
        height: 200
        anchors.left: parent.left
        anchors.top: missionCmdTopMenu.bottom
        spacing: 0
        anchors.leftMargin: 5
        anchors.topMargin: 5
        clip: true
        z: 1
        headerPositioning: ListView.OverlayHeader
        header: MissionListHeader {}
        model: activeAreaListModel
        delegate: ActiveMissionListDelegate {}
        highlight: Rectangle { color: "#6aabff"; radius: 5 }
        focus: true
        onCountChanged: resetActiveRobots()
        onCurrentIndexChanged: resetActiveRobots1()
    }

    ListView {
        id: activeRobotListView
        x: 443
        z: 1
        width: 192
        height: parent.height*0.3
        anchors.right: parent.right
        anchors.top: missionCmdTopMenu.bottom
        anchors.rightMargin: 5
        anchors.topMargin: 5
        clip: true
        headerPositioning: ListView.OverlayHeader
        header: LocListHeader { name: 'Robots' }
        delegate: ActiveRobotListDelegate {}
        model: activeRobotListModel
//        highlight: Rectangle { color: "#6aabff"; radius: 5 }
        focus: true
    }

    MissionMap {
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
