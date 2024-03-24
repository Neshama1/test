import QtQuick 2.15
import QtQuick.Controls 2.15
import org.mauikit.controls 1.3 as Maui
import QtGraphicalEffects 1.15

Maui.Page {
    id: mainMenuPage

    Maui.Theme.colorSet: Maui.Theme.Window

    headBar.visible: false

    Component.onCompleted: {
        menuSideBar.scale = 1.0
        menuSideBar.opacity = 1.0
    }

    ListModel {
    id: mainMenuModel
        ListElement { name: "Home" ; description: "Return to home screen." ; icon: "view-media-favorite" }
        ListElement { name: "App categories" ; description: "Browse by category" ; icon: "love" }
        ListElement { name: "Search" ; description: "Search across all of your store's products" ; icon: "search" }
    }

    Image {
        id: imageBackground

        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        opacity: 0.02
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

        currentIndex: indexMainMenu

        spacing: 8

        model: mainMenuModel

        delegate: Maui.ListBrowserDelegate {
            width: ListView.view.width
            height: 45
            label1.text: name
            label2.text: description

            label1.font.pointSize: 11
            label2.font.pointSize: 8

            iconSource: icon

            background: Maui.ShadowedRectangle {
                anchors.fill: parent
                color: mouse.hovered ? (Maui.ColorUtils.brightnessForColor(Maui.Theme.backgroundColor) == Maui.ColorUtils.Light ? Qt.lighter(Maui.Theme.focusColor,1.6) : Qt.lighter(Maui.Theme.alternateBackgroundColor,1.03)) : (menuSideBar.currentIndex == index ? (Maui.ColorUtils.brightnessForColor(Maui.Theme.backgroundColor) == Maui.ColorUtils.Light ? Qt.darker(Maui.Theme.focusColor,1.0) : Qt.lighter(Maui.Theme.alternateBackgroundColor,1.025)) : Qt.lighter(Maui.Theme.alternateBackgroundColor,1.025))
                border.color: Maui.ColorUtils.brightnessForColor(Maui.Theme.backgroundColor) == Maui.ColorUtils.Light ? Qt.darker(Maui.Theme.alternateBackgroundColor,1.03) : (menuSideBar.currentIndex == index ? Qt.darker("dimgrey",1.6) : Qt.darker(Maui.Theme.alternateBackgroundColor,1.03))
                border.width: 1
                radius: 7
                HoverHandler { id: mouse }
            }

            onClicked: {
                switch (index) {
                    case 0: {
                        menuSideBar.currentIndex = index
                        indexMainMenu = index
                        stackView.push("qrc:/Home.qml")
                        return
                    }
                    case 1: {
                        menuSideBar.currentIndex = index
                        indexMainMenu = index
                        stackView.push("qrc:/Categories.qml")
                        return
                    }
                    case 2: {
                        menuSideBar.currentIndex = index
                        indexMainMenu = index
                        stackView.push("qrc:/Search.qml")
                        return
                    }
                }
            }
        }
    }
}
