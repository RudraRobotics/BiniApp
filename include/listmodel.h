#ifndef LISTMODEL_H
#define LISTMODEL_H

#include <QObject>
#include <QSqlQueryModel>

class ListModel : public QSqlQueryModel
{
    Q_OBJECT
public:
    enum Roles {
        IdRole = Qt::UserRole + 1,      // id
        FNameRole,                      // Firt name
        SNameRole,                      // Last name
        NikRole                         // Nik name
    };

    explicit ListModel(QObject *parent = 0);

    // Override the method that will return the data
    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

protected:
    /* hashed table of roles for speakers.
     * The method used in the wilds of the base class QAbstractItemModel,
     * from which inherits the class QSqlQueryModel
     * */
    QHash<int, QByteArray> roleNames() const;

signals:

public slots:
    void updateModel();
    int getId(int row);
};

#endif // LISTMODEL_H
