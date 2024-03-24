import QtQuick 2.15
import QtQml 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import org.mauikit.controls 1.3 as Maui
import org.mauikit.filebrowsing 1.3 as FB

Maui.ApplicationWindow
{
    id: root
    title: qsTr("")

    property int indexCategory
    property int indexSubcategory
    property int indexMainMenu: 0
    property int indexScreenshot
    property int sideBarWidth: 215
    property var appDetail
    property string backToPage: "home"

    ListModel { id: randomListModel }
    ListModel { id: appListByCategoryModel }
    ListModel { id: appListBySubcategoryModel }
    ListModel { id: categoriesModel }
    ListModel { id: menuSubcategoryModel }
    ListModel { id: searchModel }

    ListModel {
        id: subcategoriesModel
        ListElement { category: "Audio" ; subcategory: "Midi" }
        ListElement { category: "Audio" ; subcategory: "Mixer" }
        ListElement { category: "Audio" ; subcategory: "Sequencer" }
        ListElement { category: "Audio" ; subcategory: "Tuner" }
        ListElement { category: "Audio" ; subcategory: "AudioVideoEditing" }
        ListElement { category: "Audio" ; subcategory: "Player" }
        ListElement { category: "Audio" ; subcategory: "Recorder" }
        ListElement { category: "Audio" ; subcategory: "DiscBurning" }
        ListElement { category: "Audio" ; subcategory: "Music" }
        ListElement { category: "Video" ; subcategory: "AudioVideoEditing" }
        ListElement { category: "Video" ; subcategory: "Music" }
        ListElement { category: "Video" ; subcategory: "Player" }
        ListElement { category: "Video" ; subcategory: "Recorder" }
        ListElement { category: "Video" ; subcategory: "DiscBurning" }
        ListElement { category: "Video" ; subcategory: "TV" }
        ListElement { category: "Development" ; subcategory: "Building" }
        ListElement { category: "Development" ; subcategory: "Debugger" }
        ListElement { category: "Development" ; subcategory: "Documentation" }
        ListElement { category: "Development" ; subcategory: "IDE" }
        ListElement { category: "Development" ; subcategory: "GUIDesigner" }
        ListElement { category: "Development" ; subcategory: "Profiling" }
        ListElement { category: "Development" ; subcategory: "RevisionControl" }
        ListElement { category: "Development" ; subcategory: "Translation" }
        ListElement { category: "Education" ; subcategory: "Art" }
        ListElement { category: "Education" ; subcategory: "Construction" }
        ListElement { category: "Education" ; subcategory: "Economy" }
        ListElement { category: "Education" ; subcategory: "Electricity" }
        ListElement { category: "Education" ; subcategory: "Electronics" }
        ListElement { category: "Education" ; subcategory: "Geography" }
        ListElement { category: "Education" ; subcategory: "Geology" }
        ListElement { category: "Education" ; subcategory: "Geoscience" }
        ListElement { category: "Education" ; subcategory: "History" }
        ListElement { category: "Education" ; subcategory: "Languages" }
        ListElement { category: "Education" ; subcategory: "Literature" }
        ListElement { category: "Education" ; subcategory: "Math" }
        ListElement { category: "Education" ; subcategory: "Sports" }
        ListElement { category: "Science" ; subcategory: "ArtificialIntelligence" }
        ListElement { category: "Science" ; subcategory: "Astronomy" }
        ListElement { category: "Science" ; subcategory: "Biology" }
        ListElement { category: "Science" ; subcategory: "Chemistry" }
        ListElement { category: "Science" ; subcategory: "ComputerScience" }
        ListElement { category: "Science" ; subcategory: "DataVisualization" }
        ListElement { category: "Science" ; subcategory: "Engineering" }
        ListElement { category: "Science" ; subcategory: "ImageProcessing" }
        ListElement { category: "Science" ; subcategory: "NumericalAnalysis" }
        ListElement { category: "Science" ; subcategory: "MedicalSoftware" }
        ListElement { category: "Science" ; subcategory: "Physics" }
        ListElement { category: "Science" ; subcategory: "ParallelComputing" }
        ListElement { category: "Game" ; subcategory: "Amusement" }
        ListElement { category: "Game" ; subcategory: "AdventureGame" }
        ListElement { category: "Game" ; subcategory: "ArcadeGame" }
        ListElement { category: "Game" ; subcategory: "BoardGame" }
        ListElement { category: "Game" ; subcategory: "BlocksGame" }
        ListElement { category: "Game" ; subcategory: "CardGame" }
        ListElement { category: "Game" ; subcategory: "Emulator" }
        ListElement { category: "Game" ; subcategory: "KidsGame" }
        ListElement { category: "Game" ; subcategory: "LogicGame" }
        ListElement { category: "Game" ; subcategory: "RolePlaying" }
        ListElement { category: "Game" ; subcategory: "Simulation" }
        ListElement { category: "Game" ; subcategory: "SportsGame" }
        ListElement { category: "Game" ; subcategory: "StrategyGame" }
        ListElement { category: "Graphics" ; subcategory: "2DGraphics" }
        ListElement { category: "Graphics" ; subcategory: "3DGraphics" }
        ListElement { category: "Graphics" ; subcategory: "RasterGraphics" }
        ListElement { category: "Graphics" ; subcategory: "VectorGraphics" }
        ListElement { category: "Graphics" ; subcategory: "Scanning" }
        ListElement { category: "Graphics" ; subcategory: "OCR" }
        ListElement { category: "Graphics" ; subcategory: "Photography" }
        ListElement { category: "Graphics" ; subcategory: "Publishing" }
        ListElement { category: "Graphics" ; subcategory: "Viewer" }
        ListElement { category: "Network" ; subcategory: "Chat" }
        ListElement { category: "Network" ; subcategory: "Dialup" }
        ListElement { category: "Network" ; subcategory: "FileTransfer" }
        ListElement { category: "Network" ; subcategory: "HamRadio" }
        ListElement { category: "Network" ; subcategory: "InstantMessaging" }
        ListElement { category: "Network" ; subcategory: "IRCClient" }
        ListElement { category: "Network" ; subcategory: "News" }
        ListElement { category: "Network" ; subcategory: "P2P" }
        ListElement { category: "Network" ; subcategory: "RemoteAccess" }
        ListElement { category: "Network" ; subcategory: "Telephony" }
        ListElement { category: "Office" ; subcategory: "Calendar" }
        ListElement { category: "Office" ; subcategory: "ContactManagement" }
        ListElement { category: "Office" ; subcategory: "Database" }
        ListElement { category: "Office" ; subcategory: "Dictionary" }
        ListElement { category: "Office" ; subcategory: "Chart" }
        ListElement { category: "Office" ; subcategory: "Email" }
        ListElement { category: "Office" ; subcategory: "Finance" }
        ListElement { category: "Office" ; subcategory: "FlowChart" }
        ListElement { category: "Office" ; subcategory: "PDA" }
        ListElement { category: "Office" ; subcategory: "ProjectManagement" }
        ListElement { category: "Office" ; subcategory: "Presentation" }
        ListElement { category: "Office" ; subcategory: "Spreadsheet" }
        ListElement { category: "Office" ; subcategory: "WordProcessor" }
        ListElement { category: "Settings" ; subcategory: "Settings" }
        ListElement { category: "System" ; subcategory: "FileTools" }
        ListElement { category: "System" ; subcategory: "FileManager" }
        ListElement { category: "System" ; subcategory: "Filesystem" }
        ListElement { category: "System" ; subcategory: "Monitor" }
        ListElement { category: "System" ; subcategory: "Security" }
        ListElement { category: "System" ; subcategory: "TerminalEmulator" }
        ListElement { category: "Utility" ; subcategory: "Accessibility" }
        ListElement { category: "Utility" ; subcategory: "Archiving" }
        ListElement { category: "Utility" ; subcategory: "Compression" }
        ListElement { category: "Utility" ; subcategory: "Calculator" }
        ListElement { category: "Utility" ; subcategory: "Clock" }
        ListElement { category: "Utility" ; subcategory: "TextEditor" }
        ListElement { category: "Qt" ; subcategory: "KDE" }
        ListElement { category: "GTK" ; subcategory: "GNOME" }
        ListElement { category: "Java" ; subcategory: "Java" }
    }

    Maui.SideBarView
    {
        id: _sideBarView
        anchors.fill: parent

        sideBar.preferredWidth: sideBarWidth

        Behavior on sideBar.preferredWidth {
            NumberAnimation {
                duration: 2000
                easing.type: Easing.OutExpo
            }
        }

        sideBarContent: Maui.Page
        {
            anchors.fill: parent
            Maui.Theme.colorSet: Maui.Theme.Window

            headBar.visible: false

            headBar.leftContent: [
                Maui.ToolButtonMenu
                {
                    icon.name: "application-menu"

                    MenuItem
                    {
                        text: i18n("Settings")
                        icon.name: "settings-configure"
                    }

                    MenuItem
                    {
                        text: i18n("About")
                        icon.name: "documentinfo"
                        onTriggered: root.about()
                    }
                }
            ]

            Component.onCompleted: {
                stackMenu.push("qrc:/MainMenu.qml")
            }

            StackView {
                id: stackMenu
                anchors.fill: parent
            }
        }

        Maui.Page
        {
            anchors.fill: parent

            headBar.visible: false

            Component.onCompleted: {
                stackView.push("qrc:/Home.qml")
            }

            StackView {
                id: stackView
                anchors.fill: parent
            }
        }
    }
}
