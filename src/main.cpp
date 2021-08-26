#include <QtWidgets/QApplication>
#include <QQmlApplicationEngine>
#include <QLoggingCategory>
#include <QQuickStyle>
#include <QtQuickControls2>

#include "include/qmlmqttclient.h"
#include "include/tablemodel.h"
#include "include/database.h"
#include "include/listmodel.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    app.setOrganizationName("somename");
    app.setOrganizationDomain("somename");
    QQuickStyle::setStyle("Material");
    QQmlApplicationEngine engine;
    qmlRegisterType<TableModel>("TableModel", 1, 0, "TableModel");
    qmlRegisterType<ListModel>("ListModel", 1, 0, "ListModel");
    qmlRegisterType<DataBase>("DataBase", 1, 0, "DataBase");
    qmlRegisterType<QmlMqttClient>("MqttClient", 1, 0, "MqttClient");
    qmlRegisterUncreatableType<QmlMqttSubscription>("MqttClient", 1, 0, "MqttSubscription", QLatin1String("Subscriptions are read-only"));

    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
