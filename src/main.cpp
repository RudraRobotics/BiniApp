#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QLoggingCategory>
#include <QQuickStyle>
#include <QtQuickControls2>

#include "include/qmlmqttclient.h"
#include "include/tablemodel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("Material");

    QQmlApplicationEngine engine;
    qmlRegisterType<TableModel>("TableModel", 0, 1, "TableModel");
    qmlRegisterType<QmlMqttClient>("MqttClient", 1, 0, "MqttClient");
    qmlRegisterUncreatableType<QmlMqttSubscription>("MqttClient", 1, 0, "MqttSubscription", QLatin1String("Subscriptions are read-only"));

    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}

#include "main.moc"
