import QtQuick 2.15
import QtQuick.Controls 2.15
import org.mauikit.controls 1.3 as Maui
import QtGraphicalEffects 1.15
import org.kde.novastore 1.0

Maui.Page {
    id: screenshotsPage
    showCSDControls: true

    property string buttonClicked

    headBar.visible: false

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
        clip: true

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
        screenshotArea.scale = 1.0
        screenshotArea.opacity = 1.0
    }


    Timer {
        id: waitTime
        interval: 400; running: false; repeat: false
        onTriggered: {
            if (buttonClicked == "left") {
                indexScreenshot = indexScreenshot > 0 ? indexScreenshot - 1 : 0
            }
            else {
                indexScreenshot = indexScreenshot < appDetail.pkgScreenshotsCount - 2 ? indexScreenshot + 1 : appDetail.pkgScreenshotsCount - 1
            }
            screenshotImage.opacity = 1
        }
    }

    // Screenshot area

    Rectangle {
        id: screenshotArea

        anchors.fill: parent
        anchors.margins: 20
        border.color: Qt.rgba(0, 0, 0, 0.3)
        border.width: 1
        color: "transparent"
        radius: 5

        scale: 1.1 + Math.random() * 0.3
        opacity: 0

        Behavior on scale {
            NumberAnimation {
                duration: 1000 + Math.random() * 1000
                easing.type: Easing.OutCubic
            }
        }

        Behavior on opacity {
            NumberAnimation { duration: 400 + Math.random() * 200 }
        }

        // Back button

        Button {
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.margins: 20
            width: 40
            height: 40
            icon.name: "draw-arrow-back"
            z: 1
            background: Rectangle {
                anchors.fill: parent
                radius: 5 // width
                border.color: Qt.rgba(0, 0, 0, 0.3)
                border.width: 1
                color: Maui.Theme.backgroundColor
            }

            onClicked: {
                stackView.pop()
            }
        }

        // Left button

        Button {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: 20
            width: 25
            height: 25
            icon.name: "draw-arrow-back"
            icon.width: 12
            icon.height: 12
            z: 1

            background: Rectangle {
                anchors.fill: parent
                radius: width
                border.color: Qt.rgba(0, 0, 0, 0.3)
                border.width: 1
                color: Maui.Theme.backgroundColor
            }

            onClicked: {
                if (indexScreenshot != 0) {
                    buttonClicked = "left"
                    screenshotImage.opacity = 0
                    waitTime.start()
                }
            }
        }

        // Right button

        Button {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: 20
            width: 25
            height: 25
            icon.name: "draw-arrow-forward"
            icon.width: 12
            icon.height: 12
            z: 1
            background: Rectangle {
                anchors.fill: parent
                radius: width
                border.color: Qt.rgba(0, 0, 0, 0.3)
                border.width: 1
                color: Maui.Theme.backgroundColor
            }

            onClicked: {
                if (indexScreenshot != appDetail.pkgScreenshotsCount - 1) {
                    buttonClicked = "right"
                    screenshotImage.opacity = 0
                    waitTime.start()
                }
            }
        }

        // Screenshot

        Image {
            id: screenshotImage

            anchors.fill: parent
            anchors.margins: 1

            Behavior on opacity {
                NumberAnimation { duration: 300 }
            }

            property bool adapt: true
            fillMode: Image.PreserveAspectCrop

            source: appDetail.pkgScreenshots[indexScreenshot]

            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: Item {
                    width: screenshotImage.width
                    height: screenshotImage.height
                    Rectangle {
                        id: screenshotRadius
                        anchors.centerIn: parent
                        width: screenshotImage.adapt ? screenshotImage.width : Math.min(screenshotImage.width, screenshotImage.height)
                        height: screenshotImage.adapt ? screenshotImage.height : width
                        radius: 5
                    }
                }
            }
        }
    }
}
