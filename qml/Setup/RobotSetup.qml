import QtQuick 2.12
import QtQml 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Styles 1.4
import "../../js/Database.js" as JS
import "../delegates"

Item {
    id: item1
    Rectangle {
        id: rectangle
        height: item1.height*0.35
        color: "#626262"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top

        ColumnLayout {
            id: columnLayout
            anchors.fill: parent

            Rectangle {
                height: 20
                opacity: 0.7
                color: "#354dc1"
                Layout.margins: 5
                Layout.rightMargin: 5
                Layout.bottomMargin: 5
                Layout.topMargin: 5
                Layout.leftMargin: 5
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text {
                    text: qsTr("Robot information")
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                    font.pointSize: 12
                    anchors.leftMargin: 10
                }
            }

            RowLayout {
                id: rowLayout
                width: 100
                height: 100
                Layout.fillHeight: true
                Layout.fillWidth: true

                Text {
                    id: text2
                    width: 115
                    text: qsTr("Name")
                    font.pixelSize: 14
                    verticalAlignment: Text.AlignVCenter
                    Layout.leftMargin: 10
                    Layout.maximumWidth: 115
                    Layout.minimumWidth: 115
                    Layout.preferredWidth: 115
                    Layout.bottomMargin: 5
                    Layout.topMargin: 5
                    Layout.fillHeight: true
                    Layout.fillWidth: false
                }

                TextField {
                    id: name
                    placeholderText: "Enter robot name"
                    clip: true
                    Layout.rightMargin: 10
                    Layout.bottomMargin: 5
                    Layout.topMargin: 5
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
            }

            RowLayout {
                id: rowLayout1
                width: 100
                height: 100
                Layout.fillHeight: true
                Layout.fillWidth: true

                Text {
                    id: text3
                    text: qsTr("Address")
                    font.pixelSize: 14
                    verticalAlignment: Text.AlignVCenter
                    Layout.leftMargin: 10
                    Layout.minimumWidth: 115
                    Layout.preferredWidth: 115
                    Layout.fillHeight: true
                    Layout.fillWidth: false
                    Layout.bottomMargin: 5
                    Layout.topMargin: 5
                }

                TextField {
                    id: connection
                    placeholderText: "Enter robot ip address"
                    clip: true
                    Layout.rightMargin: 10
                    Layout.bottomMargin: 5
                    Layout.topMargin: 5
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
            }

            Button {
                id: button
                width: 50
                height: 40
                text: qsTr("Save")
                Layout.rightMargin: 600
                Layout.minimumWidth: 100
                Layout.preferredWidth: 100
                Layout.fillWidth: false
                Layout.fillHeight: true
                Layout.bottomMargin: 5
                Layout.leftMargin: 5
                Layout.topMargin: 5
                onClicked: {
                    if(name.text.length && connection.left) {
                        JS.dbInsertRobot(name.text, connection.text)
                        robotListModel.append({'name': name.text, 'connection': connection.text})
                    }
                    else {
                        name.focus = true
                        connection.focus = true
                    }
                }
            }
        }
    }

    ListModel {
        id: robotListModel
        Component.onCompleted: {
            clear()
            JS.dbReadRobots()
        }
    }

    ListView {
        id: listView
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: rectangle.bottom
        anchors.bottom: parent.bottom
        clip: true
        anchors.bottomMargin: 0
        anchors.topMargin: 0
        delegate: RobotListDelegate {}
        model: robotListModel
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
