cmake_minimum_required(VERSION 3.14)

project(BiniApp LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# QtCreator supports the following variables for Android, which are identical to qmake Android variables.
# Check https://doc.qt.io/qt/deployment-android.html for more information.
# They need to be set before the find_package(...) calls below.

#if(ANDROID)
#    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
#    if (ANDROID_ABI STREQUAL "armeabi-v7a")
#        set(ANDROID_EXTRA_LIBS
#            ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libcrypto.so
#            ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libssl.so)
#    endif()
#endif()

find_package(QT NAMES Qt6 Qt5 COMPONENTS Core Quick Sql Network Mqtt REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Quick Sql Network Mqtt REQUIRED)

include_directories(
    /opt/ros/noetic/include
)

set(PROJECT_SOURCES
    database.cpp
    listmodel.cpp
    main.cpp
    qml.qrc
)

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
	qt_add_executable(BiniApp
        ${PROJECT_SOURCES}
    )
else()
    if(ANDROID)
	    add_library(BiniApp SHARED
            ${PROJECT_SOURCES}
        )
    else()
	    add_executable(BiniApp
          ${PROJECT_SOURCES}
        )
    endif()
endif()

target_compile_definitions(BiniApp
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(BiniApp
  PRIVATE Qt${QT_VERSION_MAJOR}::Core
  Qt${QT_VERSION_MAJOR}::Quick
  Qt${QT_VERSION_MAJOR}::Sql
  Qt${QT_VERSION_MAJOR}::Network
  Qt${QT_VERSION_MAJOR}::Mqtt
  /opt/ros/noetic/lib/libroscpp.so
  /opt/ros/noetic/lib/librosconsole.so
  /opt/ros/noetic/lib/libroscpp_serialization.so
  /opt/ros/noetic/lib/librostime.so
)
