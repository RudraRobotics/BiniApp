import QtQuick 2.12
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.3


Item {
    id: mapping
    property string map_path: "../maps/map1.pgm"
    property point map_origin: "-10.0, -10.0" // in meters
    property real resolution: 0.05

    Flickable {
        id: mapItemArea
        height: mapping.height*0.6
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        clip: true
        contentWidth: image.width; contentHeight: image.height

        Image {
            id: image
            source: "../maps/map1.pgm"
            fillMode: Image.PreserveAspectFit
            PinchHandler { }
            MultiPointTouchArea {
                anchors.fill: parent
                touchPoints: [
                    TouchPoint { id: point1 },
                    TouchPoint { id: point2 }
                ]
                onPressed: {
                    fnameFieldX.text = point1.x * resolution+map_origin.x
                    fnameFieldY.text = (image.height - point1.y) * resolution+map_origin.y
                }
            }
        }
    }

    RowLayout {
        id: rowLayout
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: mapItemArea.bottom
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        anchors.topMargin: 5

        spacing: 0

        Text { text: qsTr("Coordinate:")}
        TextEdit { id: fnameFieldX ; text: "0.0"; readOnly: true }
        TextEdit { id: fnameFieldY ; text: "0.0"; readOnly: true }
        Text {text: qsTr("Name")}
        TextField { id: snameField }

        Button {
            text: qsTr("Add")
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
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        anchors.bottomMargin: 5
        anchors.topMargin: 5

        TableViewColumn {
            role: "nik"
            title: "Name"
        }
        TableViewColumn {
            role: "fname"
            title: "x"
        }
        TableViewColumn {
            role: "sname"
            title: "y"
        }

        model: myModel
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
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
