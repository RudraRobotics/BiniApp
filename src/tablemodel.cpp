#include <QDebug>
#include <QSqlRecord>
#include "include/tablemodel.h"

TableModel::TableModel(QObject *parent) :
    QSqlTableModel(parent)
{
    setTable("NameTable");
    select();
    this->updateModel();
}

int TableModel::rowCount(const QModelIndex &) const
{
    return 11;
}

int TableModel::columnCount(const QModelIndex &) const
{
    return 4;
}

QVariant TableModel::data(const QModelIndex &index, int role) const
{
    QVariant value = QSqlQueryModel::data(index, role);
    if(role <Qt::UserRole)
    {
        value = QSqlQueryModel::data(index, role);
    }
    else
    {
        int columnIdx = role-Qt::UserRole/*-1*/;
        QModelIndex modelIndex = this->index(index.row(), columnIdx);
        value = QSqlQueryModel::data(index, Qt::DisplayRole);
    }
    qDebug() << value;
    return value;
}

QHash<int, QByteArray> TableModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[FNameRole] = "fname";
    roles[SNameRole] = "sname";
    roles[NikRole] = "nik";
    return roles;
}

void TableModel::updateModel()
{
    // The update is performed SQL-queries to the database
//    for (int i = 0; i < rowCount(); ++i) {
//        qDebug() << record(i).value("FisrtName") << record(i).value("SurName") << record(i).value("Nik");
//    }
}

// Getting the id of the row in the data view model
int TableModel::getId(int row)
{
    return this->data(this->index(row, 0), 0).toInt();
}
