import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQml 2.12

Flickable {
    id: flickable

    anchors.fill: parent
    anchors.topMargin: overlayHeader.height
    anchors.leftMargin: !inPortrait ? drawer.width : undefined

    contentHeight: column.height
    contentWidth: column.width

    Image {
        id: column
        source: "../maps/map.pgm"
    }

    ScrollIndicator.vertical: ScrollIndicator { }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:1.33;height:480;width:640}D{i:7}
}
##^##*/
