/* LumaOS Calamares slideshow */

import QtQuick 2.0;
import calamares.slideshow 1.0;

Presentation
{
    id: presentation

    Timer {
        interval: 20000
        repeat: true
        onTriggered: presentation.goToNextSlide()
    }

    Slide {
        Image {
            id: background
            source: "slide-bg.jpeg"
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
        }

        Rectangle {
            id: logoCard
            width: 196
            height: 196
            radius: 44
            color: Qt.rgba(0.02, 0.03, 0.05, 0.92)
            anchors.centerIn: parent

            Image {
                source: "lumaos-logo.png"
                width: 148
                height: 148
                fillMode: Image.PreserveAspectFit
                anchors.centerIn: parent
            }
        }
    }
}
