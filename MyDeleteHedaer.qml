import QtQuick
Rectangle{
    id:deleteHedaer
    visible: showDeletBtn
    width: parent.width
    height:showDeletBtn? 50:0
    Row{
        width: parent.width
        height: parent.height-10
        spacing: 95
        CustomBtn{
            width: parent.width/3
            btnColor:"green"
            btnText:"cancle"
            btnOnClick:()=>{
                           titleListviewRoot.showDeletBtn=false
                           deleteArr=[]
                           numberofDeletedElemant=0
                           for (var i = 0; i < mainNoteList.count; i++) {
                               var deletedNote = mainNoteList.get(i);
                               if (deletedNote.showDeletedBtn===true ) {
                                   mainNoteList.set(i,{showDeletedBtn:false })
                               }
                           }
                       }
        }
        
        CustomBtn{
            width: parent.width/3
            btnColor:"red"
            btnText:"Delete("+numberofDeletedElemant +")"
            btnOnClick:()=>{
                           for (var x = 0; x < deleteArr.length; x++) {
                               for (var i = 0; i < mainNoteList.count; i++) {
                                   var deletedNote = mainNoteList.get(i);
                                   if (deletedNote.showDeletedBtn===true ) {
                                       mainNoteList.remove(i)
                                   }
                               }
                           }
                           titleListviewRoot.showDeletBtn=false
                           deleteArr=[]
                           numberofDeletedElemant=0
                       }
        }
    }
}
