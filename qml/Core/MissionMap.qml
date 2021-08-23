import QtQuick 2.12
import "../../js/componentCreation.js" as MyScript
import "../../js/Database.js" as JS


Item {
    property alias map_path: mapImg.source
    property alias posListModel: posListModel
    property bool enable_way_pnts: false
    property real active_mission_id: -1

    ListModel {
        id: posListModel

        property real active_ind: 0

        signal posChanged

        onCountChanged: {
            if(count > 0) {
                objCreated()
                get(count - 1).sprite_item.onPoseChanged.connect(poseChanged)
            }
        }
    }

    signal resetItems
    signal objCreated
    signal updateActiveMission(real mission_id)

    signal poseChanged
    signal createSprite(string name)

    onUpdateActiveMission: {
        console.log(mission_id)
        if(mission_id !== active_mission_id) {
            MyScript.resetMissionWayPnts()
            var results = JS.dbReadWayPnts(mission_id)
            for (var i = 0; i < results.rows.length; i++) {
                MyScript.createMissionWayPnt(results.rows.item(i).x, results.rows.item(i).y, "../images/loc.png", results.rows.item(i).name, false)
            }
        }
        active_mission_id = mission_id
    }

    onResetItems: {
        MyScript.resetSpriteObjects()
        posListModel.clear()
    }

    onCreateSprite: {
        MyScript.createSpriteObjects(flickableMap.width/2, flickableMap.height/2, "../images/bini.png", name, true)
    }

    Image {
        id: mapImg
        source: "../../maps/map1.pgm"
        x: (parent.width-width)/2
        y: (parent.height-height)/2
        PinchHandler {}
        DragHandler {}
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
