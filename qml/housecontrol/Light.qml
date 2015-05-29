import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtGraphicalEffects 1.0

Rectangle {
    id: lightRoot;
    color: "gray";
    //opacity: 0.5;
    smooth: true;
    antialiasing: true;
    width: 400;
    height: 500;
    x: 200;
    y: 200;

    FontLoader { id: fontName; source: "../Fonts/方正兰亭纤黑简体.ttf"; }

    Rectangle {
        id: container
        height: 16
        radius: 8
        opacity: 0.7
        smooth: true
        anchors {
            top: parent.top; left: parent.left; right: parent.right
            leftMargin: 70; rightMargin: 70; topMargin: 70
        }
        gradient: Gradient {
            GradientStop { position: 0.0; color: "gray" }
            GradientStop { position: 1.0; color: "white" }
        }
        Rectangle {
            id: slider
            x: 1; y: 1; width: 30; height: 14
            radius: 6
            smooth: true
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#424242" }
                GradientStop { position: 1.0; color: "black" }
            }
            MouseArea {
                anchors.fill: parent
                anchors.margins: -16
                drag.target: parent;
                drag.axis: Drag.XAxis
                drag.minimumX: 2;
                drag.maximumX: container.width -32
            }
        }
        Text {
            text: "off";
            color: "white";
            font { family: fontName.name; pixelSize: 30; bold: true;  }
            x: 0;
            y: -35;
        }
        Text {
            text: "on";
            color: "white";
            font { family: fontName.name; pixelSize: 30; bold: true;  }
            x: 220;
            y: -35;
        }
    }

    Canvas {
        id: canvasGradient
        width: 300;
        height: 300;
        y: 150;
        anchors.horizontalCenter: parent.horizontalCenter;
        smooth: true;
        antialiasing: true;

        onPaint: {
            var ctx = getContext("2d");
            ctx.lineWidth = 5;

            // Make canvas all white
            ctx.beginPath();
            ctx.clearRect(0, 0, width, height);
            ctx.fill();

            var len = 1000;
            var last = 0, start = 0;
            while (last <= len*2) {
                last += len/2000;

                /*
                  RGB:
                  red:    255   0   0
                  yellow: 255 255   0
                  green:    0 255   0
                  blue:     0   0 255
                */
                if (last <= len/2)  // 四象限red->yellow
                    ctx.strokeStyle = Qt.rgba(1, last/(len/2), 0, 1);
                if (last > len/2 && last <= len)    // 三象限yellow->green
                    ctx.strokeStyle = Qt.rgba((len-last)/(len/2), 1, 0, 1);
                if (last > len && last <= len*3/2)  // 二象限green->blue
                    ctx.strokeStyle = Qt.rgba(0, (len*3/2-last)/(len/2), (last-len)/(len/2), 1);
                if (last > len*3/2 && last <= len*2)// 一象限blue->red
                    ctx.strokeStyle = Qt.rgba((last-len*3/2)/(len/2), 0, (len*2-last)/(len/2), 1);

                ctx.beginPath();
                ctx.arc(150, 150, 135, Math.PI*start/len, Math.PI*last/len, false);
                ctx.stroke();

                start = last;
            }
        }
    }
}
