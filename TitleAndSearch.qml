import QtQuick

    Column{
        spacing:5
        width: parent.width-20

        Row{
            width: parent.width
            height:40
            Text{
                verticalAlignment: TextInput.AlignVCenter
                width: parent.width*0.82
                text: "Todo List"
                font.pixelSize: 30
                color: "Black"
                font.bold: true
            }
            Rectangle{
                height:parent.height
                width: 52
                color: "green"
                radius: 20
                Text{
                    anchors.centerIn: parent
                    text: "+"
                    font.pixelSize: 20
                    color: "white"
                    font.bold: true
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        detailsNoteList.append({title:"",description:"",states:true,showDeletedBtn:false })
                        addnoteListview.visible=true

                        addnoteListview.isEditMode=false
                        titleListview.visible=false
                    }
                }
            }
        }


        Rectangle {
            id: searchTextFieldContainerId
            width: parent.width
            height:40
            color: "#d3d3d3"
            radius: 5
            clip:true
            Text {
                height:40
                verticalAlignment: TextInput.AlignVCenter
                text: "🔍"
                font.pixelSize: 20
                leftPadding: 5
            }
            TextInput {
                width: parent.width - 30
                height: 40
                id: searchInputId
                text: searchQuery
                font.pixelSize: 24
                verticalAlignment: TextInput.AlignVCenter
                color: "#a8a8a8"
                leftPadding: 35
                onTextChanged: {
                    searchQuery = text;
                }
            }
        }
}
