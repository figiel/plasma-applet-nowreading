import QtQuick 1.1
import org.kde.plasma.core 0.1 as PlasmaCore
import org.kde.plasma.components 0.1 as PlasmaComponents

ListView {
    PlasmaCore.DataSource {
        id: nowReadingEngine
        engine: "nowreading"
        connectedSources: sources
        interval: 500
    }
    model: PlasmaCore.DataModel {
        dataSource: nowReadingEngine

    }
    delegate:
        MouseArea {
        onClicked: Qt.openUrlExternally("file://" + model["DataEngineSource"])
        height: 40
        width: parent.width
        Column{
            width: parent.width
            height: parent.height
            Text {
                text: model["DataEngineSource"]
//                height: 40
            }
            Row {
                width: parent.width
                height: 40
                PlasmaComponents.ProgressBar {
                    id: progBar
                    minimumValue: 1
                    maximumValue: model["totalPages"]
                    value: model["currentPage"]
                    width: parent.width - 40
//                    height: 10
                }
                Text {
                    text: parseInt((model["currentPage"]/model["totalPages"])*100)+"%"
                }
            }
        }
    }
}

