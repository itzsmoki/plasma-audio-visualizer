import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.kcmutils as KCM
import org.kde.plasma.core as PlasmaCore

KCM.SimpleKCM {
    id: root
    property alias cfg_desktopWidgetBg: desktopWidgetBackgroundRadio.value
    property alias cfg_hideWhenIdle: hideWhenIdleCheckbox.checked
    property int cfg_visualizerStyle
    property string cfg_barColors
    property string cfg_waveFillColors
    property alias cfg_debugMode: debugModeCheckbox.checked
    property alias cfg_idleTimer: idleTimerSpinbox.value
    property alias cfg_hideToolTip: hideToolTipCheckbox.checked
    property alias cfg_disableLeftClick: disableLeftClickCheckbox.checked
    property string cfg_leftClickAction
    property string cfg_leftClickCommand

    Kirigami.FormLayout {
        id: parentLayout
        Layout.fillWidth: true

        RowLayout {
            Kirigami.FormData.label: i18n("Auto-hide when idle:")
            CheckBox {
                id: hideWhenIdleCheckbox
            }
            Label {
                text: i18n("After")
            }
            SpinBox {
                id: idleTimerSpinbox
                enabled: hideWhenIdleCheckbox.checked
                from: 1
                to: 60
            }
            Label {
                text: i18n("seconds")
            }
        }

        RadioButton {
            Kirigami.FormData.label: i18n("Desktop background:")
            text: i18n("Default")
            checked: desktopWidgetBackgroundRadio.value == PlasmaCore.Types.StandardBackground
            onCheckedChanged: () => {
                if (checked) {
                    desktopWidgetBackgroundRadio.value = PlasmaCore.Types.StandardBackground;
                }
            }
            ButtonGroup.group: desktopWidgetBackgroundRadio
        }
        RadioButton {
            text: i18n("Transparent")
            checked: desktopWidgetBackgroundRadio.value == PlasmaCore.Types.NoBackground
            onCheckedChanged: () => {
                if (checked) {
                    desktopWidgetBackgroundRadio.value = PlasmaCore.Types.NoBackground;
                }
            }
            ButtonGroup.group: desktopWidgetBackgroundRadio
        }
        RowLayout {
            RadioButton {
                text: i18n("Transparent with shadow")
                checked: desktopWidgetBackgroundRadio.value == PlasmaCore.Types.ShadowBackground
                onCheckedChanged: () => {
                    if (checked) {
                        desktopWidgetBackgroundRadio.value = PlasmaCore.Types.ShadowBackground;
                    }
                }
                ButtonGroup.group: desktopWidgetBackgroundRadio
            }
        }
        ButtonGroup {
            id: desktopWidgetBackgroundRadio
            property int value: PlasmaCore.Types.StandardBackground
        }
        RowLayout {
            Kirigami.FormData.label: i18n("Disable tooltip:")
            CheckBox {
                id: hideToolTipCheckbox
            }
            Kirigami.ContextualHelpButton {
                toolTipText: i18n("Disable ToolTip that shows the widget name and description.")
            }
        }
        RowLayout {
            Kirigami.FormData.label: i18n("Disable left click:")
            CheckBox {
                id: disableLeftClickCheckbox
            }
            Kirigami.ContextualHelpButton {
                toolTipText: i18n("Applet popup will still be accessible from the right click menu.")
            }
        }

        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: i18n("Left click action")
        }

        ComboBox {
            id: leftClickActionCombo
            Kirigami.FormData.label: i18n("Action:")
            model: [i18n("Open popup"), i18n("Run command")]
            currentIndex: cfg_leftClickAction === "command" ? 1 : 0
            onActivated: {
                cfg_leftClickAction = currentIndex === 1 ? "command" : "none";
            }
            enabled: !disableLeftClickCheckbox.checked
        }

        RowLayout {
            Kirigami.FormData.label: i18n("Command:")
            visible: leftClickActionCombo.currentIndex === 1
            enabled: !disableLeftClickCheckbox.checked
            TextField {
                id: leftClickCommandField
                Layout.minimumWidth: 350
                placeholderText: ""
                text: cfg_leftClickCommand
                onTextChanged: cfg_leftClickCommand = text
            }
            Kirigami.ContextualHelpButton {
                toolTipText: i18n("Shell command to run when left-clicking the widget.")
            }
        }

        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: i18n("Troubleshooting")
        }

        RowLayout {
            Kirigami.FormData.label: i18n("Debug mode:")
            CheckBox {
                id: debugModeCheckbox
            }
            Kirigami.ContextualHelpButton {
                toolTipText: i18n("Print additional messages to the system log. To make it easier to spot sizing issues, this will also force full height to the first visualizer bar and displays a grid over it.")
            }
        }
    }
}
