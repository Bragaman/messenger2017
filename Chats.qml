import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

 ApplicationWindow {
     visible: true
     height: 600
     width: 400

     Rectangle {
         height: 80
         width:parent.width
         color:"lightgray"

         TextField{
             id: searchText
             height: 30
             width: parent.parent.width
             style: TextFieldStyle {
                 background:
            Rectangle {
                     border.width: 0
                     color: "white"
                 }
             }
             placeholderText: qsTr("Поиск")
         }
     }

     Component {
         id: contactDelegate
         Item {
             id: contactItem
             width: parent.width;
             state: "Normal"
             visible: RegExp(searchText.text,"i").test(name)
             height: visible ? 80 : 0

             Column {
                 Rectangle{
                     id: itemRect
                     width: contactItem.width
                     height: contactItem.height

                     Image{
                         id: itemIcon
                         width: 80
                         height: 80
                         x: 5
                         y: 5
                         fillMode: Image.PreserveAspectFit
                         source: icon
                     }

                     Text {
                         id: iconText
                         height: 40
                         x: 100
                         y: 5
                         verticalAlignment: Text.AlignVCenter
                         renderType: Text.NativeRendering
                         font.pixelSize: 14
                         text: name
                         font.bold: true
                         wrapMode: parent.width - 40
                     }

                     Text {
                         id: last_sender
                         height: 40
                         x: 100
                         y: 40
                         verticalAlignment: Text.AlignVCenter
                         renderType: Text.NativeRendering
                         font.pixelSize: 14
                         text: last_s + ":"
                         font.bold: true
                     }

                     Text {
                         id: last_m
                         height: 40
                         x: 180
                         y: 40
                         verticalAlignment: Text.AlignVCenter
                         renderType: Text.NativeRendering
                         font.pixelSize: 14
                         text: last_mes
                     }

                     Text {
                         id: last_time
                         height: 40
                         x: parent.width - 35
                         y: 5
                         verticalAlignment: Text.AlignVCenter
                         renderType: Text.NativeRendering
                         font.pixelSize: 12
                         text: last_t
                     }
                 }
             }

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
     ListView {
         id: listView
         width: parent.width
         height: parent.height - 40
         y:40
         model: List{}
         delegate: contactDelegate

     }
 }
