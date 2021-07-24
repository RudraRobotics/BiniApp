import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.3


Rectangle {
    id: mapping
    property string map_path: "../maps/map1.pgm"
    property point map_origin: "10.0, 10"
    property real resolution: 0.05
    property point map_size: "384, 384"

    RowLayout {
        id: rowLayout
        height: 25
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: mapItemArea.bottom
        anchors.margins: 5
        anchors.topMargin: 5

        spacing: 5

        Text { text: qsTr("Coordinate:")}
        TextEdit { id: fnameFieldX ;width: 20 ;readOnly: true }
        TextEdit { id: fnameFieldY ;width: 20 ;readOnly: true }
        Text {text: qsTr("Name")}
        TextField {
            id: snameField
        }

        Button {
            text: qsTr("Add")
            width: parent.width*0.3
            // Make a new entry in the database
            onClicked: {
                database.inserIntoTable(fnameFieldX.text , fnameFieldY.text, snameField.text)
                myModel.updateModel() // And updates the data model with a new record
            }
        }

    }


    TableView {
        id: tableView
        anchors.left: parent.left
        anchors.top: rowLayout.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 5
        anchors.rightMargin: 5
        anchors.topMargin: 5
        anchors.bottomMargin: 5
        anchors.leftMargin: 5

        TableViewColumn {
            role: "fname"
            title: "Table Name"
        }
        TableViewColumn {
            role: "sname"
            title: "Last name"
        }
        TableViewColumn {
            role: "nik"
            title: "Nik name"
        }

        model: myModel

        // Setting lines in TableView to intercept mouse left click
        rowDelegate: Rectangle {
            anchors.fill: parent
            color: styleData.selected ? 'skyblue' : (styleData.alternate ? 'whitesmoke' : 'white');
            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.RightButton | Qt.LeftButton
                onClicked: {
                    tableView.selection.clear()
                    tableView.selection.select(styleData.row)
                    tableView.currentRow = styleData.row
                    tableView.focus = true

                    switch(mouse.button) {
                    case Qt.RightButton:
                        contextMenu.popup() // Call the context menu
                        break
                    default:
                        break
                    }
                }
            }
        }
    }

    // The context menu offers deleting a row from the database
    Menu {
        id: contextMenu

        MenuItem {
            text: qsTr("Remove")
            onTriggered: {
                /* Call the dialog box that will clarify the intention to remove the row from the database
                 * */
                dialogDelete.open()
            }
        }
    }

    // Dialog of confirmation the removal line from the database
    MessageDialog {
        id: dialogDelete
        title: qsTr("Remove record")
        text: qsTr("Confirm the deletion of log entries")
        icon: StandardIcon.Warning
        standardButtons: StandardButton.Ok | StandardButton.Cancel

        // If the answer ...
        onAccepted: {
            /* ... remove the line by id, which is taken from the data model
             * on the line number in the presentation
             * */
            database.removeRecord(myModel.getId(tableView.currentRow))
            myModel.updateModel();
        }
    }

    Item{
        id: mapItemArea
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 174
        anchors.leftMargin: 0
        clip: true
        Image {
            id: mapImg
            anchors.fill: parent
            source: map_path
            anchors.bottomMargin: 0
            anchors.leftMargin: 178
            anchors.topMargin: 0
            anchors.rightMargin: 159
            fillMode: Image.PreserveAspectFit
            // Images are loaded asynchronously, only useful for local images
            asynchronous: true
            Image {
                id: loc_icon
                x: mapDragArea.mouseX/resolution + map_origin.x
                y: mapDragArea.mouseY/resolution + map_origin.y
                width: 22
                height: 13
                source: "../images/loc.png"
                visible: false
            }
        }

        MouseArea {
            id: mapDragArea
            anchors.fill: mapImg
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 1
            anchors.topMargin: 0
            //            drag.target: mapImg
//            // Here, the picture will not be dragged out of the display area whether it is larger or smaller than the display frame
//            drag.minimumX: (mapImg.width > mapItemArea.width) ? (mapItemArea.width - mapImg.width) : 0
//            drag.minimumY: (mapImg.height > mapItemArea.height) ? (mapItemArea.height - mapImg.height) : 0
//            drag.maximumX: (mapImg.width > mapItemArea.width) ? 0 : (mapItemArea.width - mapImg.width)
//            drag.maximumY: (mapImg.height > mapItemArea.height) ? 0 : (mapItemArea.height - mapImg.height)

//            onWheel: {                                 // Every scroll is a multiple of 120
//                var datla = wheel.angleDelta.y/120
//                if(datla > 0)
//                {
//                    mapImg.scale = mapImg.scale/0.9
//                }
//                else
//                {
//                    mapImg.scale = mapImg.scale*0.9
//                }
//            }
            onClicked: {
                var x_real_pos = map_size.x*resolution-(mapDragArea.mouseX*resolution-map_origin.x*resolution)+map_size.x*resolution
                var y_real_pos = map_size.y*resolution-(mapDragArea.mouseY*resolution-map_origin.y*resolution)
                console.log(mapImg.width, mapImg.height)
                fnameFieldX.text = x_real_pos
                fnameFieldY.text = y_real_pos
                loc_icon.x = mapDragArea.mouseX
                loc_icon.y = mapDragArea.mouseY
                loc_icon.visible = true
            }

        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
