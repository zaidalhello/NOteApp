#ifndef NOTELISTMODEL_H
#define NOTELISTMODEL_H

#include <QAbstractListModel>
#include <QString>

struct Note {
    QString title;
    QString description;
    bool states;
    bool showDeletedBtn;
};

class NoteListModel : public QAbstractListModel {
    Q_OBJECT

public:
    enum NoteRoles {
        TitleRole = Qt::UserRole + 1,
        DescriptionRole,
        StatesRole,
        ShowDeletedBtnRole
    };

    explicit NoteListModel(QObject* parent = nullptr);

    int rowCount(const QModelIndex& parent = QModelIndex()) const override;
    QVariant data(const QModelIndex& index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE  void addNote(const QString& title, const QString& description, bool newState, bool showDeletedBtn);


    Q_INVOKABLE void updateNoteState(int index, const QString& title, const QString& description, bool newState, bool showDeletedBtn);

    Q_INVOKABLE  void deleteNote(int index);

private:
    QList<Note> m_notes;
};

#endif // NOTELISTMODEL_H
