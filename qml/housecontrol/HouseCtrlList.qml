import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1


Rectangle {
    id:housectrllistroot
    width: 200
    height: 300
    smooth: true;
    color: "black"
    property var lastCtrlType:"none";


    Column{
        anchors.left: parent.left
        anchors.top: parent.top
        spacing: 50;


           Loader{
               id:unit1;
               sourceComponent: ctrlunitComponent;
               onLoaded: {
                   item.imagesource = "images/house.png";
                   item.unittype = "light"
               }
           }

           Loader{
               id:unit2;
               sourceComponent: ctrlunitComponent;
               onLoaded: {
                   item.imagesource = "images/house.png";
                   item.unittype = "plug"
               }
           }

           Loader{
               id:unit3;
               sourceComponent: ctrlunitComponent;
               onLoaded: {
                   item.imagesource = "images/house.png";
                   item.unittype = "Air Conditioner"
               }
           }

           Loader{
               id:unit4;
               sourceComponent: ctrlunitComponent;
               onLoaded: {
                   item.imagesource = "images/house.png";
                   item.unittype = "Air Cleaner"
               }
           }

    }


    function deviceCtrl(type,running)
    {

        if(lastCtrlType != type)
        {
            switch(lastCtrlType)
            {
            case "light":
                    unit1.item.running = false;
                    opcityhidectrl.running = true;
                break;

            case "plug":
                    unit2.item.running = false;
                break;

            case "Air Conditioner":
                 unit3.item.running = false;
                break;

            case "Air Cleaner":
                unit4.item.running = false;
                break;
            }



        }

        switch(type)
        {
        case "light":
                opcityshowctrl.running = running;
                opcityhidectrl.running = !running;
            break;

        case "plug":
            break;

        case "Air Conditioner":
            break;

        case "Air Cleaner":
            break;
        }

        lastCtrlType = type;
    }

    //显示控制设备列表组件
    Component{
        id:ctrlunitComponent;
        Item{
            id:ctrlunit;
            property var imagesource:"";
            property var unittype:"";
            property var running:false;
            width:31;
            height:31;
            Image {
                id: ctrlunitImage
                anchors.fill: parent;
                source:imagesource;
            }

            Text {
                id: ctrlunitname
                x:parent.x-10
                y:parent.y+parent.height
                color:"white"
                text: qsTr(unittype)
                visible: true;
            }

            MouseArea{
                anchors.fill: parent;
                onPressed: {

                    if(lastCtrlType == unittype)
                    {
                        running = !running;
                    }
                    else
                    {
                       running = true;
                    }

                    if(running == true)
                    {
                        console.log("open ",unittype);
                    }
                    else
                    {
                        console.log("close ",unittype);
                    }

                    housectrllistroot.deviceCtrl(unittype,running);
                }
            }
        }
    }


    //设备
    //灯光控制设备
    LightCtrl{
        id:lightctrl;
        x:unit1.x + 100;
        y:unit1.y;
        visible: true;
        opacity: 0;

    }


    //显示动画效果
     PropertyAnimation {
         id:opcityshowctrl;
         targets: lightctrl;
         property: "opacity";
         from: 0;
         to: 0.6;
         duration: 1000;
     }

     PropertyAnimation {
         id:opcityhidectrl;
         targets: lightctrl;
         property: "opacity";
         from: 0.6;
         to: 0;
         duration: 1000;
     }



    Component.onCompleted: {

    }
}

