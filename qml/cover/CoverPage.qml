import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {

    Label {
        id: label
        anchors.left: parent.left
        padding: Theme.paddingMedium
        text: qsTr("Latest query")
    }

    CoverActionList {
        id: coverAction

        CoverAction {
            iconSource: "image://theme/icon-m-refresh"
        }
    }

    BusyIndicator {
        running: false
        anchors.centerIn: parent
        size: BusyIndicatorSize.Large
    }
}
