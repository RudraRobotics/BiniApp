import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQml 2.3
import QtQuick.Controls 2.3

Item {
    id: navigation
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.rightMargin: 0
    anchors.leftMargin: 0
    anchors.bottomMargin: 0
    anchors.topMargin: 0

    GridNavigation {
        id: gridNavigation

        color: "#d8d1d1"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.rightMargin: 160
        anchors.leftMargin: 0
        anchors.topMargin: 0
    }

    Button {
        id: serve
        height: 36
        text: "SERVE"
        anchors.left: gridNavigation.right
        anchors.right: parent.right
        anchors.top: comboBox.bottom
        anchors.rightMargin: 8
        anchors.topMargin: 20
        anchors.leftMargin: 6

        background: Rectangle {
            color: "#ded3d3"
            implicitWidth: 100
            implicitHeight: 40
            border.color: "#26282a"
            border.width: 1
            radius: 5
        }
        onClicked: {
            serve.highlighted = !serve.highlighted
            console.log(gridNavigation.mission.length)
            client.publish(comboBox.currentText+"_cmd", "mission_" + gridNavigation.mission, 0, false)
            pageLoader.source = "Mission.qml"
//            if(gridNavigation.mission.length==0) {
//                onClicked: popup.open()
//            }
//            else {
//                client.publish(comboBox.currentText+"_cmd", "mission_" + gridNavigation.mission, 0, false)
//                pageLoader.source = "Mission.qml"
//            }
        }
    }

    Popup {
        id: popup
        x: 100
        y: 100
        contentItem: Text {
            text: "Please select destination locations"
        }
        width: navigation.width*0.5
        height: navigation.height*0.5
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
    }

    Button {
        id: reset
        text: qsTr("RESET")
        anchors.left: gridNavigation.right
        anchors.right: parent.right
        anchors.top: serve.bottom
        anchors.rightMargin: 11
        anchors.topMargin: 20
        anchors.leftMargin: 3

        background: Rectangle {
            color: "#ded3d3"
            implicitWidth: 100
            implicitHeight: 40
            border.color: "#26282a"
            border.width: 1
            radius: 5
        }
        onClicked: {
            reset.highlighted = !reset.highlighted
        }

        Connections {
            target: reset
            onClicked: console.log("clicked")
        }
    }

    ComboBox {
        id: comboBox
        anchors.left: gridNavigation.right
        anchors.right: parent.right
        anchors.top: text1.bottom
        anchors.rightMargin: 11
        anchors.leftMargin: 9
        anchors.topMargin: 20
        currentIndex: 2
        textRole: "text"
        model: ListModel {
            id: cbItems
            ListElement { text: "bini1"; }
            ListElement { text: "bini2"; }
            ListElement { text: "bini3"; }
        }
        onCurrentIndexChanged: console.debug(cbItems.get(currentIndex).text + ", " + cbItems.get(currentIndex).color)
    }

    Text {
        id: text1
        y: 13
        height: 31
        text: qsTr("Select Robot")
        anchors.left: gridNavigation.right
        anchors.right: parent.right
        font.pixelSize: 14
        wrapMode: Text.NoWrap
        font.bold: false
        minimumPointSize: 19
        minimumPixelSize: 19
        fontSizeMode: Text.FixedSize
        anchors.rightMargin: 16
        anchors.leftMargin: 9
    }

}


/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:1.33;height:480;width:640}
}
##^##*/
