import QtQuick 2.1
import Sailfish.Silica 1.0

Page {
    id: page
    allowedOrientations: Orientation.All

    PageHeader {
        id: headertitle
        title: qsTr("Finna Viewer")
    }

    TextField {
        id: queryfield
        description: qsTr("Type search parameters, name or anything")
        anchors.top: headertitle.bottom
        placeholderText: qsTr("Type query here")
        EnterKey.iconSource: "image://theme/icon-m-enter"
        EnterKey.onClicked: focus = false

        onActiveFocusChanged: {
            if (text) {
                app.queryField = text
                fetchQuery(text)
            }
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
                height: 130
                spacing: Theme.paddingMedium

                Image {
                    width: 100
                    height: 130
                    source: (imgurl) ? "https://api.finna.fi" + imgurl : "image://theme/icon-m-attach"
                }

                Column {
                    height: childrenRect.height

                    Label {
                        elide: Text.ElideRight
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
           MenuItem {
               text: qsTr("More results")
               onClicked: {
                   app.pageNumber += 1
                   app.fetchQuery("bowie", true)
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
        if (status === PageStatus.Active) {
            pageStack.pushAttached(Qt.resolvedUrl("Settings.qml"))
        }
    }

    Component.onCompleted: fetchQuery("bowie")
}
