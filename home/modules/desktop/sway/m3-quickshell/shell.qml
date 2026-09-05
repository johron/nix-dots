import Quickshell
import Quickshell.Wayland
import QtQuick


ShellRoot {
    Variants {
        model: Quickshell.screens

        delegate: PanelWindow {
            required property var modelData
            
            screen: modelData
            
            anchors.bottom: true
            anchors.left: true
            anchors.right: true
            implicitHeight: 32
            color: "#1a1b26"

            Text {
                anchors.centerIn: parent
                text: "Monitor Profile: " + (parent.screen ? parent.screen.name : "Initializing...")
                color: "#a9b1d6"
            }
        }
    }
}
