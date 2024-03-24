import QtQuick 2.15
import QtQuick.Controls 2.15
import org.mauikit.controls 1.3 as Maui
import QtGraphicalEffects 1.15
import org.kde.novastore 1.0

Maui.Page {
    id: searchPage
    showCSDControls: true

    property string query
    property int count

    headBar.background: Rectangle {
        anchors.fill: parent
        Maui.Theme.inherit: false
        Maui.Theme.colorSet: Maui.Theme.View
        color: Maui.Theme.backgroundColor
        visible: false
    }

    background: Rectangle {
        anchors.fill: parent
        anchors.topMargin: headBar.height
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
        holder.scale = 1.0
        holder.opacity = 1.0
    }

    headBar.middleContent: Maui.SearchField {
        anchors.horizontalCenter: parent.horizontalCenter
        onAccepted: {
            gridApps.scale = 1.1 + Math.random() * 0.3
            gridApps.opacity = 0

            holder.scale = 1.1 + Math.random() * 0.3
            holder.opacity = 0

            query = text

            waitTime.start()
        }
    }

    Timer {
        id: waitTime
        interval: 500; running: false; repeat: false
        onTriggered: {
            holder.visible = false
            search(query)
            gridApps.scale = 1.0
            gridApps.opacity = 1.0
        }
    }

    function search(query) {
        searchModel.clear()
        var results = AppQuery.search(query)
        for (var i = 0; i < results.length; i++) {
            searchModel.append({"pkgId": results[i].pkgId,"pkgName": results[i].pkgName,"pkgPackageName": results[i].pkgPackageName,"pkgSummary": results[i].pkgSummary,"pkgDescription": results[i].pkgDescription,"pkgIcon": results[i].pkgIcon,"pkgScreenshots": results[i].pkgScreenshots,"pkgScreenshotsCount": results[i].pkgScreenshotsCount,"pkgDeveloper": results[i].pkgDeveloper,"pkgProjectLicense": results[i].pkgProjectLicense,"pkgUrlHomepage": results[i].pkgUrlHomepage,"pkgUrlContact": results[i].pkgUrlContact,"pkgUrlDonation": results[i].pkgUrlDonation,"pkgVersion": results[i].pkgVersion})
        }
    }

    Maui.Holder
    {
        id: holder

        anchors.fill: parent
        title: i18n("App Store Search")
        body: i18n("Find the application you are looking for")
        emoji: "search"
        isMask: false

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
    }

    LinearGradient
    {
        id: mask
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: 40
        opacity: 1.0
        z: 1
        gradient: Gradient {
            GradientStop { position: 0.1; color: Maui.Theme.backgroundColor}
            GradientStop { position: 1.0; color: "transparent"}
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        radius: 5
        clip: true

        Maui.GridBrowser {
            id: gridApps
            anchors.fill: parent
            anchors.margins: 20

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

            itemSize: parent.width / 3 - 60
            itemHeight: 70
            adaptContent: true
            horizontalScrollBarPolicy: ScrollBar.AsNeeded
            verticalScrollBarPolicy: ScrollBar.AsNeeded

            model: searchModel

            delegate: Rectangle {
                id: appListRect

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
                        opacity: 0.98
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
                                width: gridApps.width
                                height: gridApps.height

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
                        appDetail = searchModel.get(index)
                        stackView.push("qrc:/Details.qml")
                    }
                }
            }
        }
    }
}
