#include "notelistmodel.h"
#include <QDebug>

NoteListModel::NoteListModel(QObject* parent)
    : QAbstractListModel(parent) {}

int NoteListModel::rowCount(const QModelIndex& parent) const {
    Q_UNUSED(parent);
    return m_notes.count();
}

QVariant NoteListModel::data(const QModelIndex& index, int role) const {
    if (!index.isValid() || index.row() >= m_notes.size()) {
        qDebug() << "Invalid index:" << index.row();
        return QVariant();
    }

    const Note& note = m_notes.at(index.row());

    switch (role) {
    case TitleRole:

        return note.title;
    case DescriptionRole:
        return note.description;
    case StatesRole:
        return note.states;
    case ShowDeletedBtnRole:
        return note.showDeletedBtn;
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> NoteListModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[TitleRole] = "title";
    roles[DescriptionRole] = "description";
    roles[StatesRole] = "states";
    roles[ShowDeletedBtnRole] = "showDeletedBtn";
    return roles;
}

void NoteListModel::addNote(const QString& title, const QString& description, bool newState, bool showDeletedBtn) {

    Note newNote;
    newNote.title = title;
    newNote.description = description;
    newNote.states = newState;
    newNote.showDeletedBtn = showDeletedBtn;
    beginInsertRows(QModelIndex(), 0, 0);
    m_notes.insert(0, newNote);
    endInsertRows();
}

void NoteListModel::updateNoteState(int index, const QString& title, const QString& description, bool newState, bool showDeletedBtn) {
    if (index >= 0 && index < m_notes.size()) {
        m_notes[index].title = title;
        m_notes[index].description = description;
        m_notes[index].states = newState;
        m_notes[index].showDeletedBtn = showDeletedBtn;
        emit dataChanged(createIndex(index, 0), createIndex(index, 0), {TitleRole, DescriptionRole, StatesRole, ShowDeletedBtnRole});
    }
}
void NoteListModel::deleteNote(int index) {
    if (index >= 0 && index < m_notes.size()) {
        beginRemoveRows(QModelIndex(), index, index);
        m_notes.removeAt(index);
        endRemoveRows();
    }
}
