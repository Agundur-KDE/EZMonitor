/*
 * SPDX-FileCopyrightText: 2025 Agundur <info@agundur.de>
 *
 * SPDX-License-Identifier: GPL-2.0-only OR GPL-3.0-only OR LicenseRef-KDE-Accepted-GPL
 *
 */

import QtCore
import QtQuick 2.15
import QtQuick.Controls 2.15 as QtControls
import QtQuick.Dialogs as QtDialogs
import QtQuick.Layouts 1.15
import org.kde.kcmutils as KCM
import org.kde.kirigami 2.20 as Kirigami
import org.kde.kquickcontrols 2.0 as KQC

KCM.SimpleKCM {
    property color cfg_bckgColor: Plasmoid.configuration.bckgColor
    property string cfg_viewMode: Plasmoid.configuration.viewMode
    property color cfg_bckgColorDefault
    property string cfg_viewModeDefault

    Kirigami.FormLayout {
        // Color background

        QtControls.GroupBox {
            Kirigami.FormData.label: i18n("View Mode:")

            RowLayout {
                id: layout

                spacing: 20

                QtControls.RadioButton {
                    id: fullViewButton

                    text: "Full"
                    checked: cfg_viewMode === "Full"
                    onClicked: cfg_viewMode = "Full"
                }

                QtControls.RadioButton {
                    id: compactViewButton

                    text: "Compact"
                    checked: cfg_viewMode === "Compact"
                    onClicked: cfg_viewMode = "Compact"
                }

            }

        }

    }

}
