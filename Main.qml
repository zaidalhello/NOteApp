import QtQuick
Window {
    width: 350
    height: 550
    visible: true
    minimumWidth: 350
    minimumHeight: 550
    maximumHeight: 550
    maximumWidth: 350
    title: qsTr("Note App")

    property string searchQuery: ""
    property int currantIndex: 0
    property bool cheakStates: true
    ListModel {
        id: mainNoteList
        ListElement { title: "Buy Groceries"; description: "Purchase milk, bread, eggs, and fruits." ;states:true ;showDeletedBtn:false }
        ListElement { title: "Morning Workout"; description: "Do 30 minutes of cardio and strength training." ;states:true;showDeletedBtn:false }
        ListElement { title: "Finish Report"; description: "Complete the final draft of the financial report." ;states:true;showDeletedBtn:false }
        ListElement { title: "Call the Bank"; description: "Schedule a call with the bank to discuss mortgage options." ;states:true;showDeletedBtn:false }
        ListElement { title: "Clean the House"; description: "Vacuum the living room and mop the kitchen floor." ;states:true;showDeletedBtn:false }
        ListElement { title: "Read a Book"; description: "Read at least 20 pages of the current book." ;states:true;showDeletedBtn:false }
        ListElement { title: "Plan Weekend Trip"; description: "Research and book accommodation for the upcoming weekend trip.";states:true;showDeletedBtn:false  }
    }
    ListModel {
        id: detailsNoteList
    }
    ListModel {
        id: filteredNoteList
    }
    onSearchQueryChanged: {
        filteredNoteList.clear();
        for (var i = 0; i < mainNoteList.count; i++) {
            var note = mainNoteList.get(i);
            if (note.title.toLowerCase().includes(searchQuery.toLowerCase()) ) {
                filteredNoteList.append(note);
            }
        }
    }


    Rectangle{
        id:root

        x:10
        y:30
        height: parent.height
        width: parent.width
        TitleAndSearch {
            visible: titleListview.visible
        }

        MyMainDetailsListview {
            id: titleListview
            visible: true

        }
    }
    AddEditDetailsListview {
        id: detailsListview
        model: detailsNoteList
        visible: false
        pageTitle:"Edit Note"
    }

    AddEditDetailsListview {
        id: addnoteListview
        model: detailsNoteList
        visible: false


    }
}






