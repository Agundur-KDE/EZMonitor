import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kcmutils as KCM
import org.kde.kirigami as Kirigami

KCM.SimpleKCM {
    id: page

    property alias cfg_displayMode: displayModeGroup.currentValue

    Kirigami.FormLayout {
        ButtonGroup {
            id: displayModeGroup

            property string currentValue: cfg_displayMode || "Full"
        }

        RadioButton {
            id: fullButton

            text: i18n("Full View")
            checked: displayModeGroup.currentValue === "Full"
            onClicked: displayModeGroup.currentValue = "Full"
            Kirigami.FormData.label: i18n("Display Mode")
            ButtonGroup.group: displayModeGroup
        }

        RadioButton {
            id: compactButton

            text: i18n("Compact View")
            checked: displayModeGroup.currentValue === "Compact"
            onClicked: displayModeGroup.currentValue = "Compact"
            ButtonGroup.group: displayModeGroup
        }

    }

}