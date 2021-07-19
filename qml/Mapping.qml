import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2


Rectangle {
    id: mapping
    RowLayout {
        id: rowLayout
        height: 25
        anchors.top: mapItemArea.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 5
        anchors.topMargin: 5
        anchors.leftMargin: 5

        spacing: 5

        Text { text: qsTr("Coordinate:")}
        TextEdit { id: fnameFieldX ;width: 20 ; text: qsTr("");readOnly: true }
        TextEdit { id: fnameFieldY ;width: 20 ;readOnly: true }
        Text {text: qsTr("Name")}
        TextField {
            id: snameField
        }
        //        Text {text: qsTr("Nik name")}
//        TextField {id: nikField}

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

    Map {
        id: mapItemArea
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 150
        anchors.rightMargin: 5
        anchors.leftMargin: 0
        anchors.topMargin: 0
        Button {
            x: 8
            y: 16
            text: qsTr("Start")
            onClicked: {
                database.inserIntoTable(fnameFieldX.text , fnameFieldY.text, snameField.text)
                myModel.updateModel() // And updates the data model with a new record
            }
        }
        Button {
            x: 8
            y: 53
            text: qsTr("Done")
            onClicked: {
                database.inserIntoTable(fnameFieldX.text , fnameFieldY.text, snameField.text)
                myModel.updateModel() // And updates the data model with a new record
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
