import QtQuick 2.15
import QtQuick.Controls 2.15
import org.mauikit.controls 1.3 as Maui
import QtGraphicalEffects 1.15

Maui.Page {
    id: menuSubcategoryPage

    Maui.Theme.colorSet: Maui.Theme.Window

    headBar.visible: false

    Component.onCompleted: {
        getMenuAudio()

        menuSideBar.scale = 1.0
        menuSideBar.opacity = 1.0
    }

    function getMenuAudio() {
        menuSubcategoryModel.clear()
        var count = subcategoriesModel.count
        for (var i = 0; i < count; i++) {
            var category = subcategoriesModel.get(i).category
            var subcategory = subcategoriesModel.get(i).subcategory
            if (category == categoriesModel.get(indexCategory).category) {
                menuSubcategoryModel.append({"subcategory": subcategory})
            }
        }
    }

    Image {
        id: imageBackground

        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        opacity: 0.04
        scale: 2 + Math.random() * 4
        clip: true
        source: "qrc:/menu-whatsapp-892926_640.jpg"

        layer.enabled: true
        layer.effect: Colorize {
            anchors.fill: imageBackground
            source: imageBackground
            hue: Math.random() * 1
            saturation: 0.9
            lightness: -0.2
        }
    }

    Maui.ListBrowser {
        id: menuSideBar

        anchors.fill: parent
        anchors.margins: 5

        scale: 1.0 + Math.random() * 0.15
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

        horizontalScrollBarPolicy: ScrollBar.AlwaysOff
        verticalScrollBarPolicy: ScrollBar.AlwaysOff

        currentIndex: -1

        spacing: 8

        model: menuSubcategoryModel

        delegate: Maui.ListBrowserDelegate {
            width: ListView.view.width
            height: 45
            label1.text: subcategory
            label1.color: Maui.ColorUtils.brightnessForColor(Maui.Theme.backgroundColor) == Maui.ColorUtils.Light ? "black" : "white"
            //label2.text: description

            label1.font.pointSize: 11
            //label2.font.pointSize: 8

            iconSource: ""

            background: Maui.ShadowedRectangle {
                anchors.fill: parent
                color: mouse.hovered ? Qt.lighter(Maui.Theme.alternateBackgroundColor,1.03) : (menuSideBar.currentIndex == index ? Qt.darker(Maui.Theme.alternateBackgroundColor,1.003) : Qt.lighter(Maui.Theme.alternateBackgroundColor,1.025))
                border.color: menuSideBar.currentIndex == index ? (Maui.ColorUtils.brightnessForColor(Maui.Theme.backgroundColor) == Maui.ColorUtils.Light ? Qt.lighter("dimgrey",2.0) : Qt.darker("dimgrey",1.6)) : Qt.darker(Maui.Theme.alternateBackgroundColor,1.03)
                border.width: 1
                radius: 7
                opacity: 1.0
                clip: true
                HoverHandler { id: mouse }

                Maui.IconItem {
                    anchors.fill: parent
                    imageSource: "qrc:/menu-whatsapp-892926_640.jpg"
                    maskRadius: Maui.Style.radiusV
                    fillMode: Image.PreserveAspectCrop
                    opacity: 0.1
                    scale: 1 + Math.random() * 10
                    visible: false // menuSideBar.currentIndex == index ? true : false
                }
            }

            onClicked: {
                menuSideBar.currentIndex = index

                indexSubcategory = index
                stackView.push("qrc:/AppsBySubcategory.qml")

                return
            }
        }
    }
}
