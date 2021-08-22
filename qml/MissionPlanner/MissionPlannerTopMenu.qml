import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.2
import QtQml 2.12


Rectangle {

    property alias x_pos: xPos.text
    property alias y_pos: yPos.text
    property alias areaName: areaName.text
    property alias enable_way_pnts: wayPointBtn.highlighted
    property alias enable_waypnt_btn: wayPointBtn.enabled
    property alias enable_base_btn: baseBtn.enabled
    property alias enable_save_btn: saveBtn.enabled
    property alias saveBtn: saveBtn.text

    signal wayPntBtnClicked
    signal baseBtnClicked
    signal saveBtnClicked

    signal mapChanged(string map_path)
    signal resetItems

    Component.onCompleted: {
        resetBtn.clicked.connect(resetItems)
        wayPointBtn.clicked.connect(wayPntBtnClicked)
        baseBtn.clicked.connect(baseBtnClicked)
        saveBtn.clicked.connect(saveBtnClicked)
    }

    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        folder: shortcuts.home
        nameFilters: [ "Map files (*.pgm)", "All files (*)" ]
        onAccepted: {
            mapChanged(fileUrl)
            resetItems()
            wayPointBtn.highlighted = false
        }
    }

    RowLayout {
        id: rowLayout
        anchors.fill: parent

        TextField {
            id: areaName
            width: 100
            text: qsTr("")
            placeholderText: "Enter Area Name"
            Layout.minimumHeight: 10
            Layout.minimumWidth: 10
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.rightMargin: 5
            Layout.bottomMargin: 5
            Layout.leftMargin: 5
            Layout.topMargin: 5
        }

        Button {
            id: saveBtn
            text: qsTr("Save")
            Layout.fillWidth: true
            Layout.margins: 5
            Layout.bottomMargin: 5
            Layout.leftMargin: 5
            Layout.topMargin: 5
            Layout.fillHeight: true
            enabled: false
            onClicked: {
                if(!areaName.length) {
                    areaName.focus = true
                }
                else {
                    baseBtn.enabled = true
                    wayPointBtn.enabled = false
                    baseBtn.highlighted = false
                    wayPointBtn.highlighted = false
                    saveBtn.enabled = false
                }
            }
        }

        Button {
            id: openBtn
            text: qsTr("open map")
            Layout.bottomMargin: 5
            Layout.leftMargin: 5
            Layout.fillWidth: true
            Layout.margins: 5
            Layout.topMargin: 5
            Layout.fillHeight: true
            onClicked: fileDialog.open()
        }

        Button {
            id: baseBtn
            text: qsTr("Base")
            Layout.bottomMargin: 5
            Layout.leftMargin: 5
            Layout.fillWidth: true
            Layout.margins: 5
            Layout.topMargin: 5
            Layout.fillHeight: true
            highlighted: false
            onClicked: highlighted =! highlighted
        }

        Button {
            id: wayPointBtn
            text: qsTr("Waypoint")
            Layout.bottomMargin: 5
            Layout.leftMargin: 5
            Layout.fillWidth: true
            Layout.margins: 5
            Layout.topMargin: 5
            Layout.fillHeight: true
            enabled: false
            onClicked: highlighted =! highlighted
        }

        Button {
            id: resetBtn
            text: qsTr("Reset")
            Layout.topMargin: 5
            Layout.fillHeight: true
            Layout.margins: 5
            Layout.bottomMargin: 5
            Layout.fillWidth: true
            Layout.leftMargin: 5
            onClicked: {
                baseBtn.enabled = true
                wayPointBtn.enabled = false
                baseBtn.highlighted = false
                wayPointBtn.highlighted = false
                saveBtn.enabled = false
                areaName.text = ''
            }
        }

        ColumnLayout {
            id: columnLayout
            width: 100
            height: 100
            Layout.rightMargin: 10
            Layout.fillWidth: true
            Layout.margins: 5
            Layout.fillHeight: true

            Text {
                id: xPos
                color: "#ffffff"
                text: qsTr("0.0")
                font.pixelSize: 14
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            Text {
                id: yPos
                color: "#ffffff"
                text: qsTr("0.0")
                font.pixelSize: 14
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }

    }
}


/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
