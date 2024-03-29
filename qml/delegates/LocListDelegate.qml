import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml 2.12

import "../../js/delegates/LocListDelegate.js" as LocListScript

Item {
    width: 180; height: 40
    property alias textEnabled: textInput.enabled

    Rectangle {
        id: rectangle
        opacity: 0.7
        color: "#515151"
        radius: 0
        border.width: 2
        anchors.fill: parent
        anchors.rightMargin: 1
        anchors.leftMargin: 1
        anchors.bottomMargin: 1
        anchors.topMargin: 1

        TextInput {
            id: textInput
            text: name
            enabled: false
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            onEditingFinished: LocListScript.updateLocListItemName()
        }
    }
    TapHandler {
        onTapped: {
            wayPntListView.currentIndex = index
        }
    }
}
