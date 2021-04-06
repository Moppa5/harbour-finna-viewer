import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"

ApplicationWindow
{
    id: app
    property bool fetching: false
    property string queryField: ""
    property int pageNumber: 1
    property string searchUrl: "https://api.finna.fi/v1/search?&page=" + pageNumber
    property var queryResults: ListModel {}

    initialPage: Component { QueryView { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: defaultAllowedOrientations

    function fetchQuery(query, more) {
        fetching = true

        if ( !more ) {
            queryResults.clear()
            pageNumber = 0
        }
        var xhr = new XMLHttpRequest
        var fullQuery = searchUrl + "&lookfor=" + query
        xhr.open("GET", fullQuery)

        xhr.onreadystatechange = function() {

            if ( xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                var results = JSON.parse(xhr.responseText)

                for (var index = 0; index<results.records.length; index++) {
                    var item = results.records[index]
                    var image = "";

                    if (item.images[0])
                        image = item.images[0]

                    queryResults.append({"title": item.title,
                                         "imgurl": image,
                                         "type": item.formats[0].translated})
                }
            }
            fetching = false
        }

        xhr.send()
    }
}
