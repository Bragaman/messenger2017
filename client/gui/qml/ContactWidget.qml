import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4

Rectangle {
    antialiasing: false
    color: Style.mainBackground

    //top rect
    Rectangle {
        z: 1
        id: searchline
        height: 40
        width: parent.width
        color: parent.color

        //search rect
        TextField {
            id: searchText
            height: 30
            width: parent.parent.width - 45
            x: 5
            y: 5

            placeholderText: qsTr("Поиск")
        }

        //add dialog button
        Button {
            id: addDialogButton

            width: 30
            height: 30
            x: parent.width - 35
            y: 5

            background: Rectangle {
                radius: 5
                color: parent.hovered ? Style.hover : Style.mainBackground
            }
            topPadding: 5
            bottomPadding: 5
            leftPadding: 5
            rightPadding: 5

            contentItem: Image {
                id: newimg
                width: 10
                height: 10
                source: "/img/new_message.png"
            }

            onClicked: {
                adding.state = "Visible"
            }
        }
    }

    //contacts view
    ListView {
        id: listView
        width: parent.width
        height: parent.height - 40

        anchors.top: searchline.bottom
        model: ContactWidgetModel {
        }
        delegate: ContactListDelegateItem {
        }
        currentIndex: -1
    }
}
