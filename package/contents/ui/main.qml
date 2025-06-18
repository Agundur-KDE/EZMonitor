import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PlasmaComponents
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid

PlasmoidItem {
    // TODO: Plasmoid.fullRepresentation and  Plasmoid.compactRepresentation
    // flow:   isVertical ? GridLayout.TopToBottom : GridLayout.LeftToRight

    id: root

    property string host: Plasmoid.configuration.Host //"192.168.178.38"
    property int port: Plasmoid.configuration.Port //8050
    property string p1: ""
    property string p2: ""
    property string summ: "0"
    property string t1: ""
    property string t2: ""
    property string tsumm: "0"
    property string displayMode: plasmoid.configuration.displayMode

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

    Plasmoid.status: PlasmaCore.Types.ActiveStatus
    Plasmoid.backgroundHints: PlasmaCore.Types.DefaultBackground | PlasmaCore.Types.ConfigurableBackground
    Layout.minimumWidth: Kirigami.Units.gridUnit * 5
    Layout.minimumHeight: Kirigami.Units.gridUnit * 5
    implicitHeight: Kirigami.Units.gridUnit * 10
    implicitWidth: Kirigami.Units.gridUnit * 10

    Loader {
        anchors.fill: parent
        sourceComponent: displayMode === "Compact" ? compactView : fullView
    }

    Timer {
        running: true
        repeat: true
        triggeredOnStart: true
        interval: 10000
        onTriggered: request('http://' + host + ':' + port + '/getOutputData', callback)
    }

    fullRepresentation: ColumnLayout {
        id: fullView

        readonly property bool isVertical: {
            switch (Plasmoid.formFactor) {
            case PlasmaCore.Types.Planar:
            case PlasmaCore.Types.MediaCenter:
            case PlasmaCore.Types.Application:
            default:
                if (root.height > root.width)
                    return true;
                else
                    return false;
            }
        }

        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        spacing: 5
        width: isVertical ? root.width : implicitWidth
        height: isVertical ? implicitHeight : root.height
        anchors.fill: parent

        PlasmaComponents.Label {
            font: Kirigami.Theme.defaultFont
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            Layout.leftMargin: 5
            wrapMode: Text.Wrap
            text: i18n("Panel 1: " + root.p1 + " Watt")
        }

        PlasmaComponents.Label {
            font: Kirigami.Theme.defaultFont
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            Layout.leftMargin: 5
            wrapMode: Text.Wrap
            text: i18n("Panel 2: " + root.p2 + " Watt")
        }

        PlasmaComponents.Label {
            font: Kirigami.Theme.defaultFont
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            Layout.leftMargin: 5
            wrapMode: Text.Wrap
            text: i18n("Total: " + summ + " Watt")
        }

        PlasmaComponents.Label {
            font: Kirigami.Theme.defaultFont
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            Layout.leftMargin: 5
            wrapMode: Text.Wrap
            text: i18n("Today: " + (Math.round(tsumm * 100) / 100) + " kWh")
        }

    }

    compactRepresentation: ColumnLayout {
        id: compactView

        width: Math.max(100, implicitWidth)
        height: Math.max(40, implicitHeight)

        RowLayout {
            anchors.centerIn: parent
            spacing: 6

            Image {
                source: "image://icon/weather-clear" // oder z. B. "applications-energy"
                width: 24
                height: 24
            }

            PlasmaComponents.Label {
                id: powerLabel

                wrapMode: Text.Wrap
                text: i18n("Total: " + summ + " Watt")
            }

        }

    }

}