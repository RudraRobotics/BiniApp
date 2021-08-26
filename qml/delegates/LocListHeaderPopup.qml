import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import "../../js/Database.js" as JS
import "../../js/LocListHeaderPopup.js" as LocListHeaderPopupScript

Item {

    ColumnLayout {
        id: columnLayout
        anchors.fill: parent

        Button {
            id: button
            text: qsTr("Edit")
            Layout.margins: 5
            Layout.fillHeight: true
            Layout.fillWidth: true
            enabled: false
        }

        Button {
            id: button1
            text: qsTr("Delete")
            Layout.margins: 5
            Layout.fillHeight: true
            Layout.fillWidth: true
            onClicked: LocListHeaderPopupScript.removeWaypnt()
        }
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:3}D{i:1}
}
##^##*/
