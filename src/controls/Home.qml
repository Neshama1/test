import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import org.mauikit.controls 1.3 as Maui
import QtGraphicalEffects 1.15
import org.kde.novastore 1.0

Maui.Page {
    id: homePage

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
            id: imageBackgroundHome

            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            opacity: 0.03
            scale: 2 + Math.random() * 4
            clip: true
            source: "qrc:/menu-whatsapp-1411048_640.jpg"

            layer.enabled: true
            layer.effect: Colorize {
                anchors.fill: imageBackgroundHome
                source: imageBackgroundHome
                hue: Math.random() * 1
                saturation: 0.9
                lightness: -0.2
            }
        }
    }

    Component.onCompleted: {
        getRandomList()

        imageDevelopmentRect.scale = 1.0
        imageDevelopmentRect.opacity = 1.0

        topRect.scale = 1.0
        topRect.opacity = 1.0

        bottomRect.scale = 1.0
        bottomRect.opacity = 1.0

        control.scale = 1.0
        control.opacity = 1.0
    }

    function getRandomList() {
        randomListModel.clear()
        var randomList = AppQuery.randomList
        for (var i = 0; i < randomList.length; i++) {
            randomListModel.append({"pkgId": randomList[i].pkgId,"pkgName": randomList[i].pkgName,"pkgPackageName": randomList[i].pkgPackageName,"pkgSummary": randomList[i].pkgSummary,"pkgDescription": randomList[i].pkgDescription,"pkgIcon": randomList[i].pkgIcon,"pkgScreenshots": randomList[i].pkgScreenshots,"pkgScreenshotsCount": randomList[i].pkgScreenshotsCount,"pkgDeveloper": randomList[i].pkgDeveloper,"pkgProjectLicense": randomList[i].pkgProjectLicense,"pkgUrlHomepage": randomList[i].pkgUrlHomepage,"pkgUrlContact": randomList[i].pkgUrlContact,"pkgUrlDonation": randomList[i].pkgUrlDonation,"pkgVersion": randomList[i].pkgVersion})
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 25
        RowLayout {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            Layout.fillHeight: true
            Layout.minimumHeight: parent.height - 300 - 15
            spacing: 10
            z: 1

            Rectangle {
                id: imageDevelopmentRect
                Layout.fillWidth: true
                Layout.minimumWidth: 100
                Layout.minimumHeight: parent.height
                color: "transparent"
                radius: 5
                scale: 1.1 + Math.random() * 0.2
                opacity: 0

                Behavior on scale {
                    NumberAnimation {
                        duration: 1500
                        easing.type: Easing.OutCubic
                    }
                }

                Behavior on opacity {
                    NumberAnimation { duration: 2000 }
                }

                Image {
                    id: imageDevelopment

                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                    opacity: 0.6
                    property bool adapt: true
                    source: "qrc:/development-daniel-korpai-pKRNxEguRgM-unsplash.jpg"

                    Colorize {
                        anchors.fill: imageDevelopment
                        source: imageDevelopment
                        hue: 0.3
                        saturation: 0.5
                        lightness: -0.2
                    }

                    layer.enabled: true
                    layer.effect: OpacityMask {
                        maskSource: Item {
                            width: imageDevelopment.width
                            height: imageDevelopment.height
                            Rectangle {
                                anchors.centerIn: parent
                                width: imageDevelopment.adapt ? imageDevelopment.width : Math.min(imageDevelopment.width, imageDevelopment.height)
                                height: imageDevelopment.adapt ? imageDevelopment.height : width
                                radius: 5
                            }
                        }
                    }
                }

                Label {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.margins: 10
                    font.pixelSize: 22
                    font.bold: true
                    opacity: 0.7
                    text: "MauiKit Development"
                }
            }
            ColumnLayout {
                Layout.minimumWidth: 0 // 60
                Layout.preferredWidth: 0
                Layout.minimumHeight: parent.height
                spacing: 10
                Rectangle {
                    id: topRect
                    Layout.fillWidth: true
                    Layout.preferredHeight: (parent.height - 10) / 2
                    color: Qt.lighter("orange",1.7)
                    radius: 5

                    scale: 1.1 + Math.random() * 0.3
                    opacity: 0

                    Behavior on scale {
                        NumberAnimation {
                            duration: 1500
                            easing.type: Easing.OutCubic
                        }
                    }

                    Behavior on opacity {
                        NumberAnimation { duration: 2000 }
                    }
                }

                Rectangle {
                    id: bottomRect
                    Layout.fillWidth: true
                    Layout.preferredHeight: (parent.height - 10) / 2
                    color: Qt.lighter("lightblue",1.25)
                    radius: 5

                    scale: 1.1 + Math.random() * 0.4
                    opacity: 0

                    Behavior on scale {
                        NumberAnimation {
                            duration: 1800
                            easing.type: Easing.OutCubic
                        }
                    }

                    Behavior on opacity {
                        NumberAnimation { duration: 2500 }
                    }
                }
            }
        }

        Column {
            Layout.minimumHeight: 15
            Layout.maximumHeight: 15
            Layout.preferredHeight: 15
            Layout.topMargin: -15
            Layout.bottomMargin: 10
            Label {
                font.pixelSize: 19
                text: "Application discovery"
            }
            Label {
                font.pixelSize: 11
                opacity: 0.60
                text: "Discover other apps, enjoy, be productive or explore"
            }
        }

        Maui.GridBrowser {
            id: control
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: -12
            anchors.rightMargin: -12
            anchors.topMargin: -30

            Layout.minimumHeight: 220
            Layout.maximumHeight: 220
            Layout.preferredHeight: 220

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

            itemSize: parent.width / 2
            itemHeight: (220 - 5 * 3) / 3
            adaptContent: true
            horizontalScrollBarPolicy: ScrollBar.AlwaysOff
            verticalScrollBarPolicy: ScrollBar.AlwaysOff

            model: randomListModel

            delegate: Rectangle {
                id: randomAppRect

                color: "transparent"
                width: GridView.view.cellWidth
                height: GridView.view.cellHeight

                Maui.ShadowedRectangle
                {
                    id: gridBackground

                    anchors.fill: parent
                    anchors.margins: 5
                    color: Qt.lighter(Maui.Theme.backgroundColor,1.0)

                    corners
                    {
                        topLeftRadius: 5
                        topRightRadius: 5
                        bottomLeftRadius: 5
                        bottomRightRadius: 5
                    }

                    shadow.xOffset: 0
                    shadow.yOffset: 0
                    shadow.color: Qt.rgba(0, 0, 0, 0.3)
                    shadow.size: 6

                    Maui.IconItem
                    {
                        id: iconItem
                        anchors.verticalCenter: parent.verticalCenter
                        width: 50
                        height: 50
                        iconSource: pkgIcon == "" ? "application-x-rpm" : pkgIcon
                        maskRadius: Maui.Style.radiusV
                        fillMode: Image.PreserveAspectCrop
                        opacity: 0.1
                        visible: false
                    }

                    Label {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.leftMargin: 7
                        anchors.rightMargin: 7
                        anchors.topMargin: 15
                        font.pixelSize: 11
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        elide: Text.ElideRight
                        text: pkgSummary
                        opacity: 0.60
                    }

                    Label {
                        id: labelPkgName
                        anchors.fill: parent
                        anchors.margins: 7
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignBottom
                        elide: Text.ElideRight
                        font.pixelSize: 16
                        text: pkgName
                        opacity: 1.0
                    }

                    Item
                    {
                        id: _iconRec
                        opacity: 0.2
                        anchors.fill: parent
                        clip: true

                        FastBlur
                        {
                            id: fastBlur
                            height: parent.height * 2
                            width: parent.width * 2
                            anchors.centerIn: parent
                            source: iconItem
                            radius: 64
                            transparentBorder: true
                            cached: true
                        }

                        OpacityMask
                        {
                            source: mask
                            maskSource: _iconRec
                        }

                        LinearGradient
                        {
                            id: mask
                            anchors.fill: parent
                            gradient: Gradient {
                                GradientStop { position: 0.2; color: "transparent"}
                                GradientStop { position: 0.8; color: gridBackground.color}
                            }

                            start: Qt.point(0, 0)
                            end: Qt.point(_iconRec.width, _iconRec.height)
                        }

                        layer.enabled: true
                        layer.effect: OpacityMask
                        {
                            maskSource: Item
                            {
                                width: control.width
                                height: control.height

                                Rectangle
                                {
                                    anchors.fill: parent
                                    radius: Maui.Style.radiusV
                                }
                            }
                        }
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        sideBarWidth = 0
                        appDetail = randomListModel.get(index)
                        stackView.push("qrc:/Details.qml")
                    }
                }
            }
        }
    }
}
