import QtQuick 2.12
import QtQml 2.12
import QtCharts 2.3
import QtQuick.Layouts 1.12

Item {
    id: item1
    width: 600
    height: 500

    ColumnLayout {
        id: columnLayout
        anchors.fill: parent

        Item {
            id: rectangle
            width: 200
            height: 200
            Layout.fillHeight: true
            Layout.fillWidth: true

            RowLayout {
                id: rowLayout
                anchors.fill: parent

                Item {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    ChartView {
                        id: chart
                        title: "Number of times Bini served"
                        anchors.fill: parent
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        legend.alignment: Qt.AlignBottom
                        antialiasing: true

                        PieSeries {
                            id: pieSeries
                            PieSlice { label: "Volkswagen"; value: 13.5 }
                            PieSlice { label: "Toyota"; value: 10.9 }
                            PieSlice { label: "Ford"; value: 8.6 }
                            PieSlice { label: "Skoda"; value: 8.2 }
                            PieSlice { label: "Volvo"; value: 6.8 }
                        }
                    }
                }
                Item {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    ChartView {
                        id: spline
                        title: "Peak time of serving"
                        anchors.fill: parent
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        antialiasing: true

                        SplineSeries {
                            name: "SplineSeries"
                            XYPoint { x: 0; y: 0.0 }
                            XYPoint { x: 1.1; y: 3.2 }
                            XYPoint { x: 1.9; y: 2.4 }
                            XYPoint { x: 2.1; y: 2.1 }
                            XYPoint { x: 2.9; y: 2.6 }
                            XYPoint { x: 3.4; y: 2.3 }
                            XYPoint { x: 4.1; y: 3.1 }
                        }
                    }
                }

            }

            Component.onCompleted: {
                // You can also manipulate slices dynamically, like append a slice or set a slice exploded
                othersSlice = pieSeries.append("Others", 52.0);
                pieSeries.find("Volkswagen").exploded = true;
            }
        }

        Item {
            id: rectangle1
            width: 200
            height: 200
            Layout.fillHeight: true
            Layout.fillWidth: true

            RowLayout {
                id: rowLayout1
                anchors.fill: parent

                ChartView {
                    title: "Daily number of service"
                    anchors.fill: parent
                    legend.alignment: Qt.AlignBottom
                    antialiasing: true

                    BarSeries {
                        id: mySeries
                        axisX: BarCategoryAxis { categories: ["2007", "2008", "2009", "2010", "2011", "2012" ] }
                        BarSet { label: "Bob"; values: [2, 2, 3, 4, 5, 6] }
                        BarSet { label: "Susan"; values: [5, 1, 2, 4, 1, 7] }
                        BarSet { label: "James"; values: [3, 5, 8, 13, 5, 8] }
                    }
                }
            }
        }
    }

}
