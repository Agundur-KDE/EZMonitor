import QtQuick 2.15
import org.kde.plasma.configuration 2.0

ConfigModel {
    ConfigCategory {
        name: i18nc("@title", "Network")
        icon: "network-wireless"
        source: "configNetwork.qml"
    }

    ConfigCategory {
        name: i18nc("@title", "Appearance")
        icon: "preferences-desktop-color"
        source: "configAppearance.qml"
    }

}
