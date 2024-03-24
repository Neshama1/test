import QtQuick 2.15
import QtQuick.Controls 2.15
import org.mauikit.controls 1.3 as Maui
import QtGraphicalEffects 1.15
import org.kde.novastore 1.0

Maui.Page {
    id: categoriesPage

    showCSDControls: true

    headBar.background: Rectangle {
        anchors.fill: parent
        Maui.Theme.inherit: false
        Maui.Theme.colorSet: Maui.Theme.View
        color: Maui.Theme.backgroundColor
        visible: false
    }

    background: Rectangle {
        anchors.fill: parent
        color: "transparent"
        radius: 5
        Image {
            id: imageBackground

            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            opacity: 0.06
            scale: 2 + Math.random() * 4
            clip: true
            source: "qrc:/menu-whatsapp-1411048_640.jpg"

            layer.enabled: true
            layer.effect: Colorize {
                anchors.fill: imageBackground
                source: imageBackground
                hue: Math.random() * 1
                saturation: 0.9
                lightness: -0.2
            }
        }
    }

    Component.onCompleted: {
        getCategories()

        gridCategories.scale = 1.0
        gridCategories.opacity = 1.0
    }

    function getCategories() {
        categoriesModel.clear()
        var categories = AppQuery.categories
        for (var i = 0; i < categories.length; i++) {
            categoriesModel.append({"category": categories[i]})
        }
    }

    Maui.GridBrowser {
        id: gridCategories
        anchors.fill: parent
        anchors.margins: 20
        itemSize: 150
        itemHeight: 150
        adaptContent: true
        horizontalScrollBarPolicy: ScrollBar.AsNeeded
        verticalScrollBarPolicy: ScrollBar.AsNeeded

        scale: 1.1 + Math.random() * 0.3
        opacity: 0

        Behavior on scale {
            NumberAnimation {
                duration: 1000 + Math.random() * 1000
                easing.type: Easing.OutCubic
            }
        }

        Behavior on opacity {
            NumberAnimation { duration: 1000 + Math.random() * 1000 }
        }

        model: categoriesModel

        delegate: Rectangle {
            color: "transparent"
            width: GridView.view.cellWidth
            height: GridView.view.cellHeight
            Rectangle {
                anchors.fill: parent
                anchors.margins: 10
                radius: 5
                color: Maui.Theme.alternateBackgroundColor
                Label {
                    anchors.fill: parent
                    anchors.margins: 10
                    font.pixelSize: 16
                    horizontalAlignment: Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                    elide: Text.ElideRight
                    text: category
                }
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    indexCategory = index
                    stackMenu.push("qrc:/MenuSubcategory.qml")
                    stackView.push("qrc:/AppsByCategory.qml")
                }
            }
        }
    }
}
