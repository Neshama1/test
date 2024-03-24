import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import org.mauikit.controls 1.3 as Maui
import QtGraphicalEffects 1.15
import org.kde.novastore 1.0

Maui.Page {
    id: detailsPage
    showCSDControls: true

    property bool showDescription: false
    property string pkgState

    Connections {
        target: AppQuery
        onSgInstallFinished: {
            /*
            lbInfo.text = status
            popupPage.open()
            */
            if (status == 1) {
                pkgState = "installed"
                getRemoveButton.text = pkgState == "installed" ? "Remove" : "Get"
            }
        }
        onSgRemoveFinished: {
            if (status == 1) {
                pkgState = "removed"
                getRemoveButton.text = pkgState == "installed" ? "Remove" : "Get"
            }
        }
    }

    Maui.PopupPage
    {
        id: popupPage
        hint: 1

        title: i18n("Title")

        Label {
            id: lbInfo
            anchors.centerIn: parent
        }
    }

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

    LinearGradient
    {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: 30
        opacity: 1.0
        z: 1
        gradient: Gradient {
            GradientStop { position: 0.1; color: Maui.Theme.backgroundColor}
            GradientStop { position: 1.0; color: "transparent"}
        }
    }

    Component.onCompleted: {
        AppQuery.packageState(appDetail.pkgPackageName[0])
        detailCard.scale = 1.0
        detailCard.opacity = 1.0
    }

    // Back button

    Maui.IconItem
    {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 20
        width: 25
        height: 25
        iconSource: "draw-arrow-back"
        maskRadius: Maui.Style.radiusV
        fillMode: Image.PreserveAspectCrop
        MouseArea {
            anchors.fill: parent
            onClicked: {
                sideBarWidth = 215
                stackView.pop()
            }
        }
    }

    // Card

    Maui.ShadowedRectangle {
        id: detailCard

        anchors.fill: parent
        anchors.leftMargin: 250
        anchors.rightMargin: 250
        anchors.topMargin: 20
        anchors.bottomMargin: 20
        radius: 5
        color: "transparent"
        clip: true

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

        onWidthChanged: {
            descriptionRectangle.height = showDescription ? detailCard.height - 100 : 35
        }

        onHeightChanged: {
            descriptionRectangle.height = showDescription ? detailCard.height - 100 : 35
        }

        ColumnLayout {
            id: columnLayout
            anchors.fill: parent
            anchors.margins: 15
            spacing: 5
            z: 1
            Label {
                id: labelPkgName
                anchors.left: parent.left
                anchors.right: parent.right
                Layout.alignment: Qt.AlignTop
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
                font.pixelSize: 20
                text: appDetail.pkgName
                z: 1
                opacity: 0.9
            }

            Label {
                id: labelPkgSummary
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: labelPkgName.bottom
                font.pixelSize: 11
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignTop
                elide: Text.ElideRight
                text: appDetail.pkgSummary
                opacity: 0.60
            }

            // Screenhots

            Maui.GridBrowser {
                id: screenshotsGrid
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: labelPkgSummary.bottom
                anchors.topMargin: 8
                opacity: 0.6
                height: 50
                itemSize: 60
                itemHeight: 60
                padding: 0
                adaptContent: false
                horizontalScrollBarPolicy: ScrollBar.AlwaysOff
                verticalScrollBarPolicy: ScrollBar.AlwaysOff

                model: appDetail.pkgScreenshotsCount

                delegate: Rectangle {
                    id: screenshotRect

                    color: "transparent"
                    width: GridView.view.cellWidth
                    height: GridView.view.cellHeight
                    Rectangle {
                        anchors.fill: parent
                        anchors.leftMargin: 0
                        anchors.rightMargin: 10
                        anchors.bottomMargin: 10
                        border.color: "black"
                        border.width: 1
                        radius: width
                        Image {
                            id: screenshotImage

                            anchors.fill: parent

                            property bool adapt: true
                            fillMode: Image.PreserveAspectCrop

                            source: appDetail.pkgScreenshots[index]

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
                                        radius: width
                                    }
                                }
                            }
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            indexScreenshot = index
                            stackView.push("qrc:/Screenshots.qml")
                        }
                    }
                }
            }

            // Details

            Maui.SectionGroup
            {
                id: detailGroup1

                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: screenshotsGrid.bottom
                anchors.leftMargin: -5
                anchors.rightMargin: -5
                anchors.topMargin: 20
                opacity: 1

                title: i18n("Version")
                description: appDetail.pkgVersion

                Maui.SectionItem
                {
                    label1.text: i18n("Developer")
                    label2.text: appDetail.pkgDeveloper
                }
                Maui.SectionItem
                {
                    label1.text: i18n("License")
                    label2.text: appDetail.pkgProjectLicense
                }
                Maui.SectionItem
                {
                    label1.text: i18n("Homepage")
                    label2.text: appDetail.pkgUrlHomepage
                }
                Maui.SectionItem
                {
                    label1.text: i18n("Contact")
                    label2.text: appDetail.pkgUrlContact
                }
                Maui.SectionItem
                {
                    label1.text: i18n("Donation")
                    label2.text: appDetail.pkgUrlDonation
                }
            }

            Maui.SectionGroup
            {
                id: descriptionSection
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: detailGroup1.bottom
                anchors.leftMargin: -5
                anchors.rightMargin: -5
                anchors.topMargin: 10

                title: "Description"

                /*
                states: [
                    State {
                        name: "maximizeDescription"
                        AnchorChanges { target: descriptionSection; anchors.top: columnLayout.top }
                    },
                    State {
                        name: "minimizeDescription"
                        AnchorChanges { target: descriptionSection; anchors.top: detailGroup1.bottom }
                    }
                ]

                transitions: Transition {
                    AnchorAnimation {
                        duration: 100
                        easing.type: Easing.OutExpo
                    }
                }
                */

                Rectangle {
                    id: descriptionRectangle
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.margins: 6
                    height: 35
                    radius: 5
                    color: "transparent"
                    opacity: 0.80

                    Label {
                        anchors.fill: parent
                        anchors.margins: 0
                        text: appDetail.pkgDescription
                        font.pixelSize: 11
                        elide: Text.ElideRight
                        wrapMode: Text.WordWrap
                    }

                    Button {
                        id: descriptionButton
                        anchors.centerIn: showDescription ? detailCard : descriptionRectangle
                        width: 40
                        height: 40
                        text: "" // detailinstalled == "No" ? "Get" : "Remove"
                        icon.name: showDescription ? "list-remove" : "list-add"

                        Behavior on opacity {
                            NumberAnimation { duration: 500 }
                        }

                        background: Rectangle {
                            anchors.fill: parent
                            border.color: Qt.rgba(0, 0, 0, 0.3)
                            border.width: 1
                            radius: width
                            color: Maui.Theme.backgroundColor
                        }

                        Timer {
                            id: waitTime
                            interval: 1000; running: false; repeat: false
                            onTriggered: {
                                descriptionRectangle.height = showDescription ? detailCard.height - 100 : 35
                                descriptionSection.anchors.top = showDescription ? columnLayout.top : detailGroup1.bottom
                                labelPkgName.opacity = showDescription ? 0 : 0.9
                                labelPkgSummary.opacity = showDescription ? 0 : 0.6
                                screenshotsGrid.opacity = showDescription ? 0 : 0.6
                                detailGroup1.opacity = showDescription ? 0 : 1
                                detailCard.scale = 1
                                detailCard.opacity = 1
                                //descriptionSection.state = showDescription ? "maximizeDescription" : "minimizeDescription"
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                showDescription = showDescription ? false : true

                                detailCard.scale = 1.1 + Math.random() * 0.3
                                detailCard.opacity = 0

                                waitTime.start()
                            }
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        propagateComposedEvents: true
                        onEntered: descriptionButton.opacity = 0.9
                        onExited: descriptionButton.opacity = 0
                    }
                }
            }

            Button {
                id: getRemoveButton
                anchors.right: parent.right
                Layout.preferredWidth: 90
                Layout.alignment: Qt.AlignBottom | Qt.AlignRight
                height: 40
                text: "Get"
                enabled: false
                z: 1
                background: Rectangle {
                    anchors.fill: parent
                    radius: width
                    border.color: Qt.rgba(0, 0, 0, 0.3)
                    border.width: 1
                    color: Maui.Theme.backgroundColor
                }
                onClicked: {
                    pkgState == "removed" ? AppQuery.install(appDetail.pkgPackageName[0]) : AppQuery.remove(appDetail.pkgPackageName[0])
                    stackView.push("qrc:/Percentage.qml")
                }
                Connections {
                    target: AppQuery
                    onSgState: {
                        pkgState = state
                        getRemoveButton.enabled = true
                        getRemoveButton.text = pkgState == "installed" ? "Remove" : "Get"
                    }
                }
                HoverHandler {
                    id: buttonMouse
                }
            }
        }

        Maui.ShadowedRectangle
        {
            id: gridBackground

            anchors.fill: parent
            anchors.margins: 5
            color: Qt.lighter(Maui.Theme.backgroundColor,1.0)
            opacity: 0.7

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
                iconSource: appDetail.pkgIcon == "" ? "application-x-rpm" : appDetail.pkgIcon
                maskRadius: Maui.Style.radiusV
                fillMode: Image.PreserveAspectCrop
                opacity: 0.1
                visible: false
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
                        width: gridBackground.width
                        height: gridBackground.height

                        Rectangle
                        {
                            anchors.fill: parent
                            radius: Maui.Style.radiusV
                        }
                    }
                }
            }
        }
    }
}
