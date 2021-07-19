#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickView>

#include "include/database.h"
#include "include/listmodel.h"

int main(int argc, char *argv[])
{
    QScopedPointer<QGuiApplication> app(new QGuiApplication(argc, argv));
    QQuickView *viewer = new QQuickView();
    QQmlContext *context = viewer->rootContext();

    DataBase database;
    ListModel *model = new ListModel();

    context->setContextProperty("myModel", model);
    context->setContextProperty("database", &database);

    viewer->setSource(QUrl("qrc:/qml/main.qml"));

    return app->exec();
}
