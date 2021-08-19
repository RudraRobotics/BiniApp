import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.2
import QtQml 2.12


Rectangle {
    height: 100
    opacity: 0.7
    color: "#4a4a4a"

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

        ComboBox {
            id: comboBox
            Layout.minimumHeight: 10
            Layout.minimumWidth: 10
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.rightMargin: 5
            Layout.bottomMargin: 5
            Layout.leftMargin: 5
            Layout.topMargin: 5
            model: ListModel {
                ListElement { text: "Drink Area 1" }
                ListElement { text: "Drink Area 2" }
                ListElement { text: "Snak Area 1" }
            }
        }


        ComboBox {
            id: comboBox1
            Layout.fillWidth: true
            Layout.margins: 5
            Layout.bottomMargin: 5
            Layout.leftMargin: 5
            Layout.topMargin: 5
            Layout.fillHeight: true
            model: ListModel {
                ListElement { text: "Bini 1" }
                ListElement { text: "Bini 2" }
                ListElement { text: "Bini 3" }
            }
        }

        Button {
            id: baseBtn
            text: qsTr("Serve")
            Layout.bottomMargin: 5
            Layout.leftMargin: 5
            Layout.fillWidth: true
            Layout.margins: 5
            Layout.topMargin: 5
            Layout.fillHeight: true
            highlighted: false
        }

        Button {
            id: wayPointBtn
            text: qsTr("Return")
            Layout.bottomMargin: 5
            Layout.leftMargin: 5
            Layout.fillWidth: true
            Layout.margins: 5
            Layout.topMargin: 5
            Layout.fillHeight: true
        }

    }
}


