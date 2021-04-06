import QtQuick 2.1
import Sailfish.Silica 1.0

Page {
    id: page
    allowedOrientations: Orientation.All

    PageHeader {
        id: headertitle
        title: qsTr("Finna-hakusovellus")
    }

    Label {
        anchors.centerIn: parent
        visible: !app.fetching && app.queryResults.count === 0
        text: qsTr("Ei hakutuloksia")
        font.pixelSize: Theme.fontSizeLarge
    }

    TextField {
        id: queryfield
        description: qsTr("Hae nimellä tai muulla nimikkeellä")
        anchors.top: headertitle.bottom
        placeholderText: qsTr("Hae...")
        EnterKey.iconSource: "image://theme/icon-m-enter"
        EnterKey.onClicked: focus = false

        onActiveFocusChanged: {
            app.queryField = text
            fetchQuery(text)
        }

        onClicked: text = ""
    }

    SilicaListView {
        id: querylist
        model: app.queryResults
        anchors.topMargin: 1.1*(headertitle.height + queryfield.height)
        anchors.fill: parent
        ScrollDecorator { flickable: querylist }

        delegate: BackgroundItem {
            height: Theme.paddingLarge + queryrow.height

            Row {
                id: queryrow
                width: parent.width
                spacing: Theme.paddingMedium

                Image {
                    width: 100
                    height: 130
                    source: (imgurl) ? "https://api.finna.fi" + imgurl : "image://theme/icon-m-attach"
                }

                Column {
                    Label {
                        text: title
                    }

                    Label {
                        text: type
                    }
                }
            }
        }

       PushUpMenu {
           id: menu
           visible: app.queryResults.count !== 0
           MenuItem {
               text: qsTr("Lataa lisää")
               onClicked: {
                   app.pageNumber += 1
                   app.fetchQuery(app.queryField, true)
                   menu.close()
               }
           }
       }
    }

    BusyIndicator {
        running: app.fetching
        anchors.centerIn: parent
        size: BusyIndicatorSize.Large
    }

    onStatusChanged: {
        /* Add attached page later when required
        if (status === PageStatus.Active) {
            pageStack.pushAttached(Qt.resolvedUrl("Settings.qml"))
        } */
    }

    Component.onCompleted: app.fetchQuery("",false)
}
