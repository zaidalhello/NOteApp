import QtQuick
Column{
    y: 95
    id:titleListviewRoot
    width: parent.width
    height: 421
    property bool showDeletBtn: false
    property int numberofDeletedElemant: 0
    property var deleteArr: []
    MyDeleteHedaer {
        id: deleteHedaer
    }
    ListView {

        id: titleListview
        width: parent.width
        height: 421

        model:filteredNoteList.count===0&&(searchQuery=== "Search"||searchQuery=== "")?mainNoteList: filteredNoteList


        delegate:Rectangle {

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(deleteBtn.visible===true){
                        return
                    }

                    currantIndex=index
                    cheakStates=model.states
                    detailsNoteList.append({title:model.title,description:model.description,states:model.states,showDeletedBtn:false })
                    detailsListview.visible=true
                    titleListviewRoot.visible=false
                }
                onPressAndHold:()=>{
                                   titleListview.contentY = 0
                                   deleteBtn.visible=true
                                   titleListviewRoot.showDeletBtn=true
                                   titleListview.contentY = 0
                               }
            }
            id: textFieldListId
            width: 320
            height: 60
            radius: 5
            clip:true
            Row{
                topPadding: 10
                anchors.fill: parent
                Rectangle{
                    visible: titleListviewRoot.showDeletBtn

                    width: 18
                    height: 40
                    CustomBtn{
                        id:deleteBtn
                        btnColor:parent.color
                        btnText:model.showDeletedBtn?"❌":"🗑"
                        btnOnClick:()=>{
                                       if (deleteArr.includes(index)) {
                                           titleListviewRoot.deleteArr.splice(index);
                                           model.showDeletedBtn=false

                                       }else{
                                           titleListviewRoot.deleteArr.push(index);
                                           model.showDeletedBtn=true
                                       }

                                       titleListviewRoot.numberofDeletedElemant=titleListviewRoot.deleteArr.length
                                       console.log(deleteArr+"/"+model.showDeletedBtn)
                                   }
                    }

                }

                Column{
                    width: model.states?parent.width-80:parent.width-110
                    Text {
                        width: parent.width
                        height: 30
                        id: editNoteTextInputId
                        text: model.title
                        font.pixelSize: 20
                        verticalAlignment: TextInput.AlignVCenter
                        color: "black"
                        focus: true
                        leftPadding: 10

                    }
                    Text {
                        width:parent.width
                        height: 18
                        text: {
                            var currentDate = new Date();
                            var year = currentDate.getFullYear();
                            var month = currentDate.getMonth() + 1;
                            var day = currentDate.getDate();
                            var formattedDate = year + '-' + (month < 10 ? '0' + month : month) + '-' + (day < 10 ? '0' + day : day);
                            var hours = currentDate.getHours();
                            var minutes = currentDate.getMinutes();
                            var seconds = currentDate.getSeconds();
                            var formattedTime = (hours < 10 ? '0' + hours : hours) + ':' +
                                    (minutes < 10 ? '0' + minutes : minutes)
                            return formattedDate + ' ' + formattedTime;
                        }
                        font.pixelSize: 14
                        verticalAlignment: TextInput.AlignVCenter
                        color: "#a8a8a8"
                        focus: true
                        leftPadding: 10
                    }

                }
                CustomBtn{

                    width:model.states?  62:90
                    btnColor:model.states?  "orange":"green"
                    btnText:model.states? "Pending":"Completed"
                    btnOnClick:()=>{
                                   if(deleteBtn.visible===true){
                                       return
                                   }

                                   mainNoteList.set(index,{title:model.title,description:model.description,states:!model.states,showDeletedBtn:false })}
                }
                Rectangle{
                    id:navigatBtn
                    visible: !showDeletBtn
                    width: 25
                    height: 40
                    Text{
                        anchors.fill:parent
                        verticalAlignment: TextInput.AlignVCenter
                        horizontalAlignment: TextInput.AlignHCenter
                        text: ">"
                        font.pixelSize: 15
                        font.bold:true
                        color: "#a8a8a8"
                    }
                }
            }
            Rectangle
            {
                width: parent.width
                height: 1
                color: "#d3d3d3"
            }
        }
        spacing: 5
        clip: true
    }
}
