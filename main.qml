import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtWebEngine 1.5
import QtWebChannel 1.0

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    title: qsTr("Google Maps")
    QtObject{
        id: mapController
        WebChannel.id: "mapController"
        property int zoomLevel:controller.zoomLevel
        signal searchForRestaurants(bool nearMe)
        signal callItem(variant searchResult)
        signal displayRouteToSearchItem(variant searchResult)
        function setZoomLevel(z) {
            // notify C++ to save new zoomLevel
            controller.setZoomLevel(z)
        }

        // put into our search model the results received from Google
        function processSearchResults(searchResults)
        {
            for(var i=0;i< searchResults.length; i++) {
                searchModel.append({"name": searchResults[i].name, "address":searchResults[i].vicinity, "distance": searchResults[i].distance.toString() + " mi", "searchResult": searchResults[i]});
            }
        }
    }
    ListModel { // holds Google search results
        id: searchModel
    }
    WebChannel {
        id:wc  // A Qt supplied javascript class
        registeredObjects: [ mapController ] // pass in the mapController object so that we can talk to/from our webbrowser
    }
    header: ToolBar {
        id: toolbar
        height:50
        background: Rectangle {
            anchors.fill: parent
            gradient: Gradient {
                GradientStop { position: 0.0; color: "darkblue" }
                GradientStop { position: 1.0; color: "blue" }
            }
        }
        Label {
            id: title
            text: "QML & Android Maps"
            anchors.centerIn: parent
            color: "white"
            font.bold: true
            font.pixelSize: 16
        }

        ToolButton {
            id: menuButton
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            background: Image {
                id: menuBackground
                source: "qrc:/icons/Hamburger.png"
            }

            onClicked: menu.open()
            Menu {
                id: menu
                y: menuButton.height
                background: Rectangle {
                    implicitWidth: 150
                    implicitHeight: 50
                    border.color: "#999"
                    border.width: 2
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "darkblue" }
                        GradientStop { position: 1.0; color: "blue" }
                    }
                }
                Label {
                    text: "Search"
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    font.bold: true
                    font.pixelSize: 12
                }

                MenuItem {
                    id: coffeeSearch
                    text: "Coffee ..."
                    highlighted: true
                    contentItem: Text {
                        anchors.centerIn: parent
                        color:coffeeSearch.pressed ? "yellow" : "white"
                        text: coffeeSearch.text
                        horizontalAlignment: Text.AlignLeft
                    }
                    background: Rectangle {
                        border.width: 1
                        border.color: "#aaa"
                        gradient: Gradient {
                            GradientStop { position: 0.0; color: "blue" }
                            GradientStop { position: 1.0; color: "darkblue" }
                        }                        width: parent.width
                        height: 30
                    }
                    onTriggered: {
                        mapController.searchForRestaurants(true);
                        workArea.state = "search"
                    }
                }
                MenuItem {
                    id: gasStationSearch
                    text: "Gas Station..."
                    highlighted: true
                    contentItem: Text {
                        color:gasStationSearch.pressed ? "yellow" : "white"
                        text: gasStationSearch.text
                        horizontalAlignment: Text.AlignLeft
                    }
                    background: Rectangle {
                        border.width: 1
                        border.color: "#aaa"
                        gradient: Gradient {
                            GradientStop { position: 0.0; color: "blue" }
                            GradientStop { position: 1.0; color: "darkblue" }
                        }                            width: parent.width
                        height: 30
                    }
                    onTriggered: {
                        console.debug("Not implemented...")
                    }
                }
            }
        }
    }
    Item {
        id: workArea
        anchors.fill: parent
        state: "normal"
        Rectangle {
            id: resultsDialog
            width: 280
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            radius: 4
            border.color: "black"
            border.width: 1
            color: "white"
            state: "normal"
            Component {
                id: searchDelegate
                MapSearchDelegate {
                    width: searchResults.width
                    height:60
                    onGoToItem: {
                        mapController.displayRouteToSearchItem(v);
                    }
                    onCallItem:  {
                        mapController.callItem(v)
                    }
                }
            }
            ColumnLayout {
                anchors.fill: parent
                RowLayout {
                    spacing: 12
                    Image {
                        id:  closeArea
                        source: "qrc:/icons/closeDialogButton.png"
                        sourceSize.width: 32
                        sourceSize.height: 32
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                workArea.state = "normal"
                            }
                        }
                    }
                    Text {
                        id: searchTitle
                        text: qsTr("Coffe Shops")
                        font.bold: true
                        font.pixelSize: 12
                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
                Component {
                    id: highlightBar
                    Rectangle {
                        z:5
                        width: searchResults.width; height: 60
                        color: "#59bafd"
                        opacity: 0.4
                        y: searchResults.currentItem.y;
                        Behavior on y { SpringAnimation { spring: 2; damping: 0.1 } }
                    }
                }
                ListView {
                    id: searchResults
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    model: searchModel;
                    delegate: searchDelegate
                    clip: true
                    focus: true
                }
            }
            Behavior on x { NumberAnimation {  easing.type: Easing.InOutQuad; duration: 750 } }
        }
        // http://doc.qt.io/qt-5/qml-qtwebengine-webengineview.html
        WebEngineView {
            id: mapView
            objectName: "webView"
            anchors.left: resultsDialog.right
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            url: googleMapsUrl
            settings.webGLEnabled: true
            webChannel: wc
        }
        states: [
            State {
                name:"normal"
                PropertyChanges {target:toolbar; height: 50}
                PropertyChanges {target: resultsDialog; x:-281}
            },
            State {
                name: "search"
                PropertyChanges {target: resultsDialog; x:0}
            }
        ]
    }
