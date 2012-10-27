import QtQuick 1.1
import org.kde.plasma.core 0.1 as PlasmaCore
import org.kde.plasma.components 0.1 as PlasmaComponents

Item {
    id: root
    width: 400
    height: 300
    clip: true

    ListView {
        id: nowreadingList
        width: parent.width
        height: parent.height

        PlasmaCore.DataSource {
            id: nowReadingEngine
            engine: "nowreading"
            connectedSources: sources
            interval: 500
        }
        model: PlasmaCore.SortFilterModel {
                  sortRole: "accessTime"
                  sortOrder: "DescendingOrder"
                  sourceModel: PlasmaCore.DataModel {
                     dataSource: nowReadingEngine
                  }
        }
        delegate: Item {
            width: parent.width
            height: 40
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onClicked: Qt.openUrlExternally("file://" + model["DataEngineSource"])
            }
            Column {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 5
                Text {
                    text: model["DataEngineSource"].substr(
                              model["DataEngineSource"].lastIndexOf('/')+1,
                              model["DataEngineSource"].lastIndexOf('.') - model["DataEngineSource"].lastIndexOf('/') - 1).replace(/\./g, " ")
                    width: parent.width
                    elide: Text.ElideRight
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
                    }
                    Text {
                        text: parseInt((model["currentPage"]/model["totalPages"])*100)+"%"
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        plasmoid.aspectRatioMode = IgnoreAspectRatio;
    }
}
