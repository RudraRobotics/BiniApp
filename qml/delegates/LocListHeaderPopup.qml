import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import "../../js/Database.js" as JS

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
            onClicked: {
                var result1 = JS.dbRemoveWayPnt(wayPntListModel.get(wayPntListView.currentIndex).waypnt_id)
                wayPntListModel.remove(wayPntListView.currentIndex)
                flickableMap.spriteListModel.get(wayPntListView.currentIndex).sprite_item.destroy()
                flickableMap.spriteListModel.remove(wayPntListView.currentIndex)
                popup.close()
            }
        }
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:3}D{i:1}
}
##^##*/
