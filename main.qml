/*
 * Copyright (C) 2020 Chandler Swift <chandler@chandlerswift.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
import QtQuick 2.9
import org.asteroid.controls 1.0
import QRCode 1.0
import QZXing 3.3
import QtQuick.VirtualKeyboard 2.0
import QtQuick.VirtualKeyboard.Settings 2.15

Application {
    id: app
	
    centerColor: "#31bee7"
    outerColor:  "#052442"

	property var fileUrl: "/home/ceres/Pictures/"
	property var imageName: ""
	property var codeText: ""
	property var getText: ""

QRCode {
	id:qrcode
}

LayerStack {
   	id: layerStack
		firstPage: qrCodePage 
}
Component{
	id:qrCodePage
	Item {
		id:rootM
		TextBox {
			id: txtField
			anchors.verticalCenter:parent.verticalCenter
    		anchors.horizontalCenter:parent.horizontalCenter
    		width: Dims.w(80)
			height: 50
			previewText: qsTrId("QRcode text")
			text:getText
			MouseArea {
    			anchors.fill: parent
    			onClicked: {
    				getText = ""
                	layerStack.push(keyboardPage);
                }
			}
		}
		IconButton {
			anchors.horizontalCenter: parent.horizontalCenter
        	anchors.bottom: parent.bottom
        	anchors.bottomMargin: Dims.h(15)
			iconName: "ios-checkmark-circle-outline"
			onClicked: { 
				codeText= txtField.text
				getText = ""
				layerStack.push(savePage)
 			}
		}
	}
}
Component{
	id:savePage
	Item {
		id:rootM
		TextBox {
			id: fileNameField
			anchors.verticalCenter:parent.verticalCenter
    		anchors.horizontalCenter:parent.horizontalCenter
    		width: Dims.w(80)
			height: 50
			previewText: qsTrId("File name to save")
			text:getText
			MouseArea {
    			anchors.fill: parent
    			onClicked: {
    				getText = ""
                	layerStack.push(keyboardPage);
                }
			}
		}
		IconButton {
			anchors.horizontalCenter: parent.horizontalCenter
        	anchors.bottom: parent.bottom
        	anchors.bottomMargin: Dims.h(15)
			iconName: "ios-checkmark-circle-outline"
			onClicked: { 
				imageName =fileNameField.text
				qrcode.generateQRCodeTest(codeText,fileUrl+imageName)
				getText = ""
				layerStack.push(imagePage)
 			}
		}
	}
}

Component{
	id:imagePage
	Item {
		id:rootM
		Image {
        	anchors.verticalCenter:parent.verticalCenter
        	anchors.horizontalCenter:parent.horizontalCenter
            source: "file://" + fileUrl + imageName + ".jpg"
            width: 300
            height: 300
            fillMode: Image.Stretch
		}
		IconButton {
			anchors.horizontalCenter: parent.horizontalCenter
        	anchors.bottom: parent.bottom
        	anchors.bottomMargin: Dims.h(15)
			iconName: "ios-checkmark-circle-outline"
			onClicked: { 
				layerStack.push(qrCodePage)
 			}
		}
	}
}

Component {
	id:keyboardPage	
	Item {
		id:rootM
		property var pop
					
		TextBox {
    		id: txtField
    		anchors.top:parent.top
    		anchors.topMargin :50
    		anchors.horizontalCenter:parent.horizontalCenter
    	    width: Dims.w(80)
    	    height:50
    	    previewText: qsTrId("")
   		}	
	
		InputPanel {
    		id: kbd
    	   	anchors {
   		    	verticalCenter: parent.verticalCenter
   		    	horizontalCenter: parent.horizontalCenter
   			}
   			width:parent.width * 0.90 //Dims.w(95)
    	   	visible: active
   		}
		IconButton {
			id:txtEnter
			anchors.bottom : parent.bottom
 			anchors.horizontalCenter : parent.horizontalCenter		
 			iconName: "ios-checkmark-circle-outline"
 			onClicked: {
				getText = txtField.text	
				layerStack.pop(rootM)				
			}
		}
		Component.onCompleted: {
		VirtualKeyboardSettings.styleName = "watch"
		
   		}
	}		
}

}





