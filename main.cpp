
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "notelistmodel.h"

int main(int argc, char* argv[]) {
    QGuiApplication app(argc, argv);

    qmlRegisterType<NoteListModel>("com.example.notelist", 1, 0, "NoteListModel");

    QQmlApplicationEngine engine;

    NoteListModel mainNoteListModel;
    mainNoteListModel.addNote("Buy Groceries", "Purchase milk, bread, eggs, and fruits.", true, false);
    mainNoteListModel.addNote("Morning Workout", "Do 30 minutes of cardio and strength training.", true, false);
    mainNoteListModel.addNote("Finish Report", "Complete the final draft of the financial report.", true, false);
    mainNoteListModel.addNote("Call the Bank", "Schedule a call with the bank to discuss mortgage options.", true, false);
    mainNoteListModel.addNote("Clean the House", "Vacuum the living room and mop the kitchen floor.", true, false);
    mainNoteListModel.addNote("Read a Book", "Read at least 20 pages of the current book.", true, false);
    mainNoteListModel.addNote("Plan Weekend Trip", "Research and book accommodation for the upcoming weekend trip.", true, false);
    engine.rootContext()->setContextProperty("mainNoteList", &mainNoteListModel);
    engine.load(QUrl::fromLocalFile("/Users/suhaila/NoteApp/Main.qml"));


    return app.exec();
}
