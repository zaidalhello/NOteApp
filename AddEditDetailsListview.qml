import QtQuick

ListView {
    property bool isEditMode: true
    property string pageTitle: isEditMode ? "Edit Note" : "Add Note"
    property bool showDeleteBtn: isEditMode
    id: detailsListview

    highlightRangeMode: ListView.NoHighlightRange
    anchors.fill: parent
    anchors.margins: 20

    header: Item {
        width: parent.width
        height: 40


        Rectangle {
            id: backBtn
            width: 50
            height: 40
            anchors.left: parent.left

            Text {
                anchors.centerIn: parent
                text: "<"
                font.pixelSize: 15
                font.bold: true
                color: "#a8a8a8"

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        detailsNoteList.clear()
                        detailsListview.visible = false
                        titleListview.visible = true
                        searchQuery = ""
                    }
                }
            }
        }

        Rectangle {
            width: parent.width - 100
            height: 40
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                anchors.centerIn: parent
                text: pageTitle
                font.pixelSize: 20
                font.bold: true
                color: "black"
            }
        }
    }

    delegate: Column {
        spacing: 20
        width: detailsListview.width

        Rectangle {
            width: parent.width - 10
            height: 50
            color: "#d3d3d3"
            radius: 5
            clip: true
            TextInput {
                id: detailesTitleFieldEditId
                anchors.fill: parent
                text: model.title
                font.pixelSize: 24
                verticalAlignment: TextInput.AlignVCenter
                color: "black"
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
                text: model.description
                font.pixelSize: 24
                color: "black"
                wrapMode: TextEdit.Wrap
                padding: 10
            }
        }
        CustomBtn {
            width: model.states ? 60 : 90
            visible: isEditMode
            btnColor: model.states ? "orange" : "green"
            btnText: model.states ? "Pending" : "Completed"
            btnOnClick: () => {
                            model.states = !model.states;
                            cheakStates = model.states;
                        }
        }
        Rectangle
        {
            width: parent.width - 10
            height:  isEditMode?150:190

            CustomBtn {
                anchors.centerIn:  parent
                visible: showDeleteBtn
                btnColor: "red"
                btnText: "Delete"
                btnOnClick: () => {

                                mainNoteList.deleteNote(currantIndex);
                                detailsNoteList.clear();
                                detailsListview.visible = false;
                                titleListview.visible = true;
                                searchQuery = "";

                            }
            }
            CustomBtn {
                anchors.bottom:  parent.bottom
                btnColor: "green"
                btnText: "Save"
                btnOnClick: () => {
                                if (isEditMode) {
                                    mainNoteList.updateNoteState(
                                        currantIndex,
                                        detailesTitleFieldEditId.text,
                                        detailesDescriptionFieldEditId.text,
                                        cheakStates,
                                        false
                                        );
                                } else {
                                    mainNoteList.addNote(
                                        detailesTitleFieldEditId.text,
                                        detailesDescriptionFieldEditId.text,
                                        true,
                                        false
                                        );
                                }
                                detailsNoteList.clear();
                                detailsListview.visible = false;
                                titleListview.visible = true;
                                searchQuery = "";
                            }
            }

        }

    }

    states: State {
        when: !isEditMode
        PropertyChanges {
            target: detailsListview
            pageTitle: "Add Note"
            showDeleteBtn: false
        }
    }
}
