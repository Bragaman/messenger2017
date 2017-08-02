import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Rectangle {
    antialiasing: false

    //top rect
    Rectangle {
        height: 40
        width:parent.width
        color:"lightgray"

        //search rect
        TextField{
            id: searchText
            height: 30
            width: parent.parent.width - 45
            x: 5
            y: 5

            style: TextFieldStyle {
                background:
                    Rectangle {
                    border.width: 0
                    color: "white"
                }
            }

            placeholderText: qsTr("Поиск")
        }



        //add dialog button
        Button {
            id: addDialogButton

            width: 30
            height: 30
            x: parent.width - 35
            y: 5

            style: ButtonStyle{
                background:
                    Rectangle {
                    border.width: 0
                    color: addDialogButton.hovered ? "#a0dea0" : "white"
                }
            }

            text: "add"

        }
    }


    // list delegate
    Component {
        id: contactDelegate
        Item {
            id: contactItem
            width: parent.width;

            //seting start state
            state: "Normal"

            //for filtering
            visible: RegExp(searchText.text,"i").test(name)
            height: visible ? 50 : 0

            // item view
            Column {
                Rectangle{
                    id: itemRect

                    width: contactItem.width
                    height: contactItem.height

                    Image{
                        id: itemIcon
                        width: 40
                        height: 40
                        x: 5
                        y: 5

                        fillMode: Image.PreserveAspectFit

                        source: icon
                    }

                    Text {
                        id: iconText
                        height: 40
                        x: 60
                        y: 5

                        verticalAlignment: Text.AlignVCenter
                        renderType: Text.NativeRendering
                        font.pixelSize: 14

                        text: name
                    }
                }
            }

            //item states
            states: [
                State {
                    name: "Normal"
                    PropertyChanges {
                        target: itemRect
                        color: listView.currentIndex == index ? "#8cb6d4" : "white"
                    }
                },
                State {
                    name: "Hover"
                    PropertyChanges {
                        target: itemRect
                        color: listView.currentIndex == index ? "#669fc4" : "#eeeeee"
                    }
                }
            ]

            //item states transitions
            transitions: [
                Transition {
                    from: "*"; to: "Normal"
                    ColorAnimation {duration: 100}
                },
                Transition {
                    from: "*"; to: "Hover"
                    ColorAnimation {duration: 100}
                }
            ]


            MouseArea {
                hoverEnabled: true
                anchors.fill: parent
                onEntered: { contactItem.state='Hover'}
                onExited: { contactItem.state="Normal"}

                onDoubleClicked: listView.currentIndex = index
            }
        }
    }



    //contacts view
    ListView {
        id: listView
        width: parent.width
        height: parent.height - 40
        y:40
        model: ContactWidgetModel{}
        delegate: contactDelegate
    }
}
