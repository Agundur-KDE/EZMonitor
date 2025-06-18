import QtQuick
import org.kde.plasma.configuration

ConfigModel {
    ConfigCategory {
        name: i18n("Misc")
        icon: "preferences-system-other"
        source: "config/ConfigMisc.qml"
    }

    ConfigCategory {
        name: i18n("Display")
        icon: "view-compact"

        ConfigEntry {
            name: "displayMode"
            type: "String"
            defaultValue: "Full"
            label: i18n("Display Mode")
            options: [
                ConfigOption {
                    name: "Compact"
                    label: i18n("Compact")
                },
                ConfigOption {
                    name: "Full"
                    label: i18n("Full")
                }
            ]
        }

    }

}