import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {

    Column {
        anchors.centerIn: parent

        Label {
            id: title
            text: (app.queryField !== "") ? qsTr("Viimeisin haku") : qsTr("Ei hakua")
        }

        Label {
            id: latestquery
            visible: app.queryField !== ""
            text: "'" + app.queryField + "'"
            horizontalAlignment: Qt.AlignCenter
        }
    }

    CoverActionList {
        id: coverAction

        CoverAction {
            iconSource: "image://theme/icon-m-refresh"
            onTriggered: app.fetchQuery(app.queryField, false)
        }
    }

    BusyIndicator {
        running: app.fetching
        anchors.centerIn: parent
        size: BusyIndicatorSize.Large
    }
}
