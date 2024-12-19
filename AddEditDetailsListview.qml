import QtQuick
ListView {
    property bool isEditMode: true
    property string pageTitle: "Edit Note"
    property bool showDeleteBtn: true
    id: detailsListview
    highlightRangeMode:ListView.NoHighlightRange
    anchors.fill: parent
    anchors.margins: 20
    header:
        Row{
        spacing: 80
        width: parent.width
        height: 40
        Rectangle{
            width: 50
            height: 40
            Text{
                width: parent.width
                height: parent.height
                anchors.fill:parent
                verticalAlignment: TextInput.AlignVCenter
                horizontalAlignment: TextInput.AlignHCenter
                text: "<"
                font.pixelSize: 15
                font.bold:true
                color: "#a8a8a8"
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        detailsNoteList.clear()
                        detailsListview.visible=false
                        titleListview.visible=true
                        searchQuery= ""
                    }
                }
            }
        }
        Rectangle{
            width: 50
            height: 40
            Text{
                width: parent.width
                height: parent.height
                anchors.fill:parent
                verticalAlignment: TextInput.AlignVCenter
                horizontalAlignment: TextInput.AlignHCenter
                text: pageTitle
                font.pixelSize: 20
                color: "black"
                focus: true
                font.bold:true
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        detailsNoteList.clear()
                        detailsListview.visible=false
                        titleListview.visible=true
                        searchQuery= ""
                    }
                }

            }
        }
    }
    delegate: Column{
        spacing: 10
        width: detailsListview.width
        height:100
        Rectangle {
            width: parent.width-10
            height: 50
            color: "#d3d3d3"
            radius: 5
            clip:true
            
            TextInput {
                anchors.fill: parent
                id: detailesTitleFieldEditId
                text: model.title
                font.pixelSize: 24
                verticalAlignment: TextInput.AlignVCenter
                color: "black"
                focus: true
                leftPadding: 10
            }
        }
        Rectangle {
            width: parent.width - 10
            height: 150
            color: "#d3d3d3"
            radius: 5
            clip: true
            TextEdit {
                id: detailesDescriptionFieldEditId
                anchors.fill: parent
                width: parent.width - 20
                height: parent.height - 10
                text: model.description
                font.pixelSize: 24
                verticalAlignment: TextEdit.AlignTop
                color: "black"
                focus: true
                leftPadding: 10
                wrapMode: TextEdit.Wrap
                padding: 10
                onTextChanged: {
                    detailesDescriptionFieldEditId.text=text
                }
                
            }
        }

        CustomBtn{
            width:model.states?  60:90
            visible: isEditMode
            btnColor:model.states?  "orange":"green"
            btnText:model.states? "Pending":"Completed"
            btnOnClick:()=> {
                           model.states=!model.states
                           cheakStates=model.states
                       }
        }
        CustomBtn{
            btnColor:"green"
            btnText:"save"
            btnOnClick:()=>{
                           if(isEditMode)
                           {
                               mainNoteList.set(currantIndex,{title:detailesTitleFieldEditId.text,description:detailesDescriptionFieldEditId.text,states:cheakStates,showDeletedBtn:false })
                           }else
                           {
                               mainNoteList.insert(0, {title: detailesTitleFieldEditId.text, description: detailesDescriptionFieldEditId.text, states: true,showDeletedBtn:false })
                           }
                           detailsNoteList.clear()
                           detailsListview.visible=false
                           titleListview.visible=true
                           searchQuery= "Search"
                       }
        }
        CustomBtn{
            visible: showDeleteBtn
            btnColor:"red"
            btnText:"Delete"
            btnOnClick:()=>{
                           mainNoteList.remove(currantIndex)
                           detailsNoteList.clear()
                           detailsListview.visible=false
                           titleListview.visible=true
                           searchQuery= ""
                       }
        }
    }
    states: State {
        when: !isEditMode
        PropertyChanges {
            target: detailsListview
            visible: true
            pageTitle:"Add Note"
            showDeleteBtn:false
        }
    }
}
