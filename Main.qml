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
        id: detailsNoteList
    }
    ListModel {
        id: filteredNoteList
    }
    onSearchQueryChanged: {
        filteredNoteList.clear();

        for (var i = 0; i < mainNoteList.rowCount(); i++) {
            var title = mainNoteList.data(mainNoteList.index(i, 0), 257);
            var description = mainNoteList.data(mainNoteList.index(i, 0), 258);
            var states = mainNoteList.data(mainNoteList.index(i, 0), 259);
            var showDeletedBtn = mainNoteList.data(mainNoteList.index(i, 0), 260);
            if (title && title.toLowerCase().includes(searchQuery.toLowerCase())) {
                filteredNoteList.append({
                                            "title": title,
                                            "description": description,
                                            "states": states,
                                            "showDeletedBtn": showDeletedBtn
                                        });
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






