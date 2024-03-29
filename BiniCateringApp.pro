QT += core quick sql network mqtt quickcontrols2 charts qml

CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        src/listmodel.cpp \
        src/main.cpp \
        src/database.cpp \
        src/qmlmqttclient.cpp \
        src/tablemodel.cpp

RESOURCES += qml.qrc

#INCLUDEPATH += tmp/moc/release_shared

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    include/database.h \
    include/listmodel.h \
    include/qmlmqttclient.h \
    include/tablemodel.h

DISTFILES +=
