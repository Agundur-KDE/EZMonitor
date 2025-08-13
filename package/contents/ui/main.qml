/*
 * SPDX-FileCopyrightText: 2025 Agundur <info@agundur.de>
 *
 * SPDX-License-Identifier: GPL-2.0-only OR GPL-3.0-only OR LicenseRef-KDE-Accepted-GPL
 *
 */

import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PlasmaComponents
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid

PlasmoidItem {
    id: root

    property string host: Plasmoid.configuration.Host //"192.168.178.38"
    property int port: Plasmoid.configuration.Port //8050
    property color bckgColor: Plasmoid.configuration.bckgColor //#2a2e32
    property string cfg_viewMode: Plasmoid.configuration.viewMode
    property string p1: ""
    property string p2: ""
    property string summ: "0"
    property string t1: ""
    property string t2: ""
    property string tsumm: "0"

    function callback(x) {
        if (x.responseText) {
            var d = JSON.parse(x.responseText);
            root.p1 = d.data.p1;
            root.p2 = d.data.p2;
            root.t1 = d.data.e1;
            root.t2 = d.data.e2;
            summ = (parseInt(root.p1) + parseInt(root.p2));
            tsumm = (parseFloat(root.t1) + parseFloat(root.t2));
        }
    }

    function request(url, callback) {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = (function f() {
            callback(xhr);
        });
        xhr.open('GET', url, true);
        xhr.send();
    }

    toolTipMainText: Plasmoid.title
    preferredRepresentation: {
        if (Plasmoid.location === PlasmaCore.Types.Floating || Plasmoid.location === PlasmaCore.Types.Desktop)
            return cfg_viewMode === "Compact" ? compactRepresentation : fullRepresentation;

        return compactRepresentation;
    }
    Plasmoid.icon: "weather-clear-symbolic"
    Plasmoid.status: PlasmaCore.Types.ActiveStatus
    Plasmoid.backgroundHints: PlasmaCore.Types.DefaultBackground | PlasmaCore.Types.ConfigurableBackground

    Timer {
        running: true
        repeat: true
        triggeredOnStart: true
        interval: 10000
        onTriggered: request('http://' + host + ':' + port + '/getOutputData', callback)
    }

    Component {
        id: windowIconComponent

        Kirigami.Icon {
            source: "weather-clear-symbolic"
            width: 22
            height: 22
        }

    }

    fullRepresentation: Item {
        id: fullView

        Layout.minimumWidth: today.implicitWidth + 10
        Layout.minimumHeight: layout.implicitHeight + 10

        ColumnLayout {
            // spacing: PlasmaCore.Units.smallSpacing

            id: layout

            anchors.fill: parent
            anchors.centerIn: parent // Zentriert das ganze Layout im Parent

            PlasmaComponents.Label {
                font: Kirigami.Theme.defaultFont
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                Layout.leftMargin: 5
                wrapMode: Text.Wrap
                text: i18n("Panel 1: " + root.p1 + " Watt")
                Layout.preferredWidth: 400
            }

            PlasmaComponents.Label {
                font: Kirigami.Theme.defaultFont
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                Layout.leftMargin: 5
                wrapMode: Text.Wrap
                text: i18n("Panel 2: " + root.p2 + " Watt")
                Layout.preferredWidth: 400
            }

            PlasmaComponents.Label {
                font: Kirigami.Theme.defaultFont
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                Layout.leftMargin: 5
                wrapMode: Text.Wrap
                text: i18n("Total: " + summ + " Watt")
                Layout.preferredWidth: 400
            }

            PlasmaComponents.Label {
                id: today

                font: Kirigami.Theme.defaultFont
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                Layout.leftMargin: 5
                wrapMode: Text.Wrap
                text: i18n("Today: " + (Math.round(tsumm * 100) / 100) + " kWh")
                Layout.preferredWidth: 400
            }

        }

    }

    compactRepresentation: Item {
        id: compactView

        Layout.minimumWidth: iconItem.implicitWidth + powerLabel.implicitWidth
        Layout.minimumHeight: powerLabel.implicitHeight

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                expanded = !expanded;
            }
            cursorShape: Qt.PointingHandCursor
        }

        RowLayout {
            id: row

            anchors.fill: parent
            anchors.centerIn: parent // Zentriert das ganze Layout im Parent
            spacing: PlasmaCore.Units.smallSpacing

            Kirigami.Icon {
                id: iconItem

                source: "weather-clear-symbolic"
                implicitWidth: Kirigami.Units.iconSizes.sizeForLabels
                implicitHeight: Kirigami.Units.iconSizes.sizeForLabels
            }

            PlasmaComponents.Label {
                id: powerLabel

                Layout.preferredWidth: 200
                wrapMode: Text.Wrap
                text: i18n("Total: " + summ + " Watt")
            }

        }

    }

}