import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.2


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
                id: multiPointTouchArea
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
        TextField { id: snameField; placeholderText: qsTr("Enter name") }

        Button {
            text: qsTr("Add")
            // Make a new entry in the database
            onClicked: {
                if(snameField.length) {
                    database.inserIntoTable(fnameFieldX.text , fnameFieldY.text, snameField.text)
                    myModel.updateModel() // And updates the data model with a new record
                }
                else {
                    snameField.focus = true
                }
            }
        }

    }

    ListModel {
        id: myModel
        ListElement { type: "Dog"; age: 8 }
        ListElement { type: "Cat"; age: 5 }
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
        clip: true

//            model: myModel

        delegate: myModel

        Popup {
            id: popup
            x: 100
            y: 100
            width: 200
            height: 300
            modal: true
            focus: true
            closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
            ColumnLayout {
                Button {
                    id: button1
                    text: "delete"
                    onClicked: {
                        database.removeRecord(myModel.getId(tableView.currentRow))
                        myModel.updateModel();
                        popup.close()
                    }
                }
                Button {
                    id: button2
                    text: "edit"
                }
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
