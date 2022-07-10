import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Controls.Styles 1.4

Button {
    id: searchToolBut
    height: 36
    width: 36
    property alias iconSource: img.source
    background: Rectangle {
        color: searchToolBut.down ? "#d6d6d6" : "#fff"
        border.color: "#555"
        border.width: 1
        radius: 6
        anchors.fill: parent
        Image {
            id: img
            anchors.centerIn:  parent
            fillMode: Image.Stretch
            sourceSize.width: 36
            sourceSize.height: 36
        }  
    }
}
