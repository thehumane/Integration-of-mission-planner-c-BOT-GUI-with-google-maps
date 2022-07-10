import QtQuick 2.4
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.2
import QtWebEngine 1.3
import QtWebChannel 1.0

Rectangle {
    id: wrapper
    border.width: 1
    signal goToItem(variant v)
    signal callItem(variant v)
    Text {
        id: nameItem
        text: name
        anchors.top: parent.top
        anchors.topMargin:3
        anchors.left: parent.left
        anchors.leftMargin:4
    }
    Text {
        id: addressItem
        text: address
        anchors.top: nameItem.bottom
        anchors.topMargin: 4
        anchors.left: parent.left
        anchors.leftMargin:4
    }
    Text {
        id: distanceItem
        text: distance
        anchors.top: parent.top
        anchors.topMargin:5
        anchors.right: parent.right
        anchors.rightMargin:4
    }
    RowLayout {
        id: buttonArea
        height:0
        visible: false
        anchors.bottom: parent.bottom
        anchors.topMargin: 6
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin:10
        anchors.rightMargin:10
        spacing: 10
        z:2
        SearchToolButton {
            id: goToB
            iconSource: "qrc:/icons/searchGoTo.png"
            Layout.preferredWidth:36
            Layout.preferredHeight:36
            Layout.maximumWidth: 36
            onClicked: {
                wrapper.goToItem(searchResult);
            }
        }
        Item {
            id: spacer
            Layout.fillWidth: true
        }
    }
    states: State {
                    name: "Current"
                    when: wrapper.ListView.isCurrentItem
                    PropertyChanges { target: wrapper; color: "#4a90e2"; height: 110}
                    PropertyChanges { target: nameItem; color: "white" }
                    PropertyChanges { target: addressItem; color: "white" }
                    PropertyChanges { target: distanceItem; color: "white" }
                    PropertyChanges { target: buttonArea; height: "64"; visible:true}
                }
    transitions: Transition {
                    ColorAnimation { properties: "color"; duration: 250 }
                    NumberAnimation { properties: "height"; duration: 200 }
                }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            wrapper.ListView.view.currentIndex = index
        }
    }
}
