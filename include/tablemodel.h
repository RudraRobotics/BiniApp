#ifndef TABLEMODEL_H
#define TABLEMODEL_H

#include <QSqlTableModel>

class TableModel : public QSqlTableModel
{
    Q_OBJECT

public:
    enum Roles {
        IdRole = Qt::UserRole + 1,      // id
        FNameRole,                      // Firt name
        SNameRole,                      // Last name
        NikRole                         // Nik name
    };

    explicit TableModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex & = QModelIndex()) const override;

    int columnCount(const QModelIndex & = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role) const override;

    QHash<int, QByteArray> roleNames() const override;

public slots:
    void updateModel();
    int getId(int row);

};

#endif // TABLEMODEL_H
