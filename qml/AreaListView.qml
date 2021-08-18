import QtQuick 2.0

ListView {
    delegate: Item {
        x: 5
        width: 80
        height: 40
        Row {
            id: row1
            spacing: 10

            Text {
                text: name
                anchors.verticalCenter: parent.verticalCenter
                font.bold: true
            }
        }
    }
    model: ListModel {
        ListElement {
            name: "Dinner Area 1"
        }

        ListElement {
            name: "Snak Area 1"
        }

        ListElement {
            name: "Drink Area 1"
        }

        ListElement {
            name: "Drink Area 2"
        }
    }
}
/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
