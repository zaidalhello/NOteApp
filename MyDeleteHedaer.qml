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
                           for (var i = 0; i < mainNoteList.rowCount(); i++) {
                               var title = mainNoteList.data(mainNoteList.index(i, 0), 257);
                               var description = mainNoteList.data(mainNoteList.index(i, 0), 258);
                               var states = mainNoteList.data(mainNoteList.index(i, 0), 259);
                               var showDeletedBtn = mainNoteList.data(mainNoteList.index(i, 0), 260);
                               if (showDeletedBtn) {
                                   mainNoteList.updateNoteState(i, title, description, states,false)

                               }
                           }
                       }
        }
        CustomBtn{
            width: parent.width/3
            btnColor:"red"
            btnText:"Delete("+numberofDeletedElemant +")"
            btnOnClick:()=>{

                           for (var i = 0; i < mainNoteList.rowCount(); i++) {

                               var showDeletedBtn = mainNoteList.data(mainNoteList.index(i, 0), 260);
                               if (showDeletedBtn) {
                                   mainNoteList.deleteNote(i)
                               }
                           }




                           titleListviewRoot.showDeletBtn=false
                           deleteArr=[]
                           numberofDeletedElemant=0
                       }
        }
    }
}
