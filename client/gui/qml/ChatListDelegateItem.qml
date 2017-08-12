import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1
import "."
import ContactsModel 1.0


RowLayout {
    function getMsgAligment() {
        if (msgListView.myMessagesDirection)
            return sentByMe ? Qt.AlignRight : Qt.AlignLeft
        return Qt.AlignLeft
    }

    function getLayoutDirection() {
        if (msgListView.myMessagesDirection)
            return sentByMe ? Qt.RightToLeft : Qt.LeftToRight
        return Qt.LeftToRight
    }

    id: delegateItem
    readonly property bool sentByMe: FromUuid == "1"
    layoutDirection: getLayoutDirection()
    Layout.alignment: getMsgAligment()
    width: parent.width

    spacing: 6

    Image {
        id: itemIcon

        fillMode: Image.PreserveAspectFit
        Layout.alignment: Qt.AlignTop
        source: contactsModel.getDataForID(FromUuid, ContactsModel.Avatar)
    }

    ColumnLayout {
        RowLayout {
            Layout.alignment: Qt.AlignTop | getMsgAligment()
            layoutDirection: getLayoutDirection()
            Text {
                id: itemUserName

                text: contactsModel.getDataForID(FromUuid, ContactsModel.Name)
                color: sentByMe ? Style.myNameColor : Style.otherNameColor
            }

            Text {
                id: itemTime
                text: model.messTime
                color: Style.chatTime
            }
        }

        Label {
            Layout.alignment: getMsgAligment()
            property real maxLen: delegateItem.width - itemIcon.width
                                  - delegateItem.spacing - 4 - padding * 2
            id: msgLabel
            text: model.messText
            color: sentByMe ?  Style.myMessageColor : Style.otherMessageColor
            wrapMode: Label.WrapAnywhere
            padding: 5

            Layout.maximumWidth: maxLen

            Connections {
                target: window
                onWidthChanged: msgLabel.Layout.maximumWidth = (msgLabel.Layout.maximumWidth
                                < msgLabel.maxLen ? msgLabel.maxLen : msgLabelBackground.width)+0.1
            }

            background: Rectangle {
                id: msgLabelBackground
                color: sentByMe ? Style.myMessageBackground : Style.otherMessageBackground
                radius: 4
                width: Math.min(msgLabel.maxLen,
                                msgLabel.paintedWidth) + parent.padding * 2
            }
        }
    }

    Item {
        Layout.fillWidth: true
    }
}
