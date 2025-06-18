import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kcmutils as KCM
import org.kde.kirigami as Kirigami

KCM.SimpleKCM {
    property string cfg_Host
    property int cfg_Port
    property string cfg_HostDefault
    property int cfg_PortDefault

    onCfg_HostChanged: {
        cfg_Host = updateIpTextField.text;
    }
    onCfg_PortChanged: {
        cfg_Port = updatePortnumberSpinBox.value;
    }

    Kirigami.FormLayout {
        QQC2.TextField {
            // validator: RegularExpressionValidator {
            //     regularExpression:  /^((?:[0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.){0,3}(?:[0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])$/
            // }

            id: updateIpTextField

            inputMask: "000.000.000.000;_"
            readOnly: false
            text: cfg_Host
            Kirigami.FormData.label: "EZ1 IP:"
            onEditingFinished: cfg_Host = text
        }

        QQC2.SpinBox {
            id: updatePortnumberSpinBox

            value: cfg_Port
            Kirigami.FormData.label: "EZ1 Port:"
            stepSize: 1
            from: 1
            to: 65535
            textFromValue: function(value) {
                return value;
            }
            onValueChanged: cfg_Port = textFromValue(value)

            validator: IntValidator {
                bottom: updatePortnumberSpinBox.from
                top: updatePortnumberSpinBox.to
            }

        }

    }

}