import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import org.mauikit.controls 1.3 as Maui
import QtGraphicalEffects 1.15
import org.kde.novastore 1.0

Maui.Page {
    id: percentagePage

    showCSDControls: true

    headBar.visible: false

    headBar.background: Rectangle {
        anchors.fill: parent
        Maui.Theme.inherit: false
        Maui.Theme.colorSet: Maui.Theme.View
        color: Maui.Theme.alternateBackgroundColor
        visible: false
    }

    background: Rectangle {
        anchors.fill: parent
        color: "mediumseagreen"
    }

    Connections {
        target: AppQuery
        onSgPercentage: {
            lbPercentage.text = percentage.toString();
        }
        onSgInstallFinished: {
            if (status == 1) {
            }
            stackView.pop()
        }
        onSgRemoveFinished: {
            if (status == 1) {
            }
            stackView.pop()
        }
    }


    Component.onCompleted: {
        scale = 1.0
        opacity = 1.0
    }

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

    Rectangle {
        anchors.centerIn: parent
        width: 150
        height: 150
        radius: width
        color: Maui.Theme.backgroundColor
        ColumnLayout {
            anchors.centerIn: parent
            width: parent.width
            height: parent.height
            Label {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.topMargin: 40
                Layout.bottomMargin: -10
                text: "%"
                width: parent.width
                font.pixelSize: 40
                font.weight: Font.Thin
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            Label {
                id: lbPercentage
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.bottomMargin: 40
                width: parent.width
                font.pixelSize: 20
                font.weight: Font.Thin
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
    }
}
