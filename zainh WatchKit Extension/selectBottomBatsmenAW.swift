//
//  selectBottomBatsmenAW.swift
//  Scorebook WatchKit Extension
//
//  Created by Chintan Shah on 2021-01-22.
//

import Foundation
import WatchKit

class selectBottomBatsmenAW: WKInterfaceController{
    @IBOutlet var bottomBatsmenName: WKInterfaceLabel!
    @IBOutlet var bottomBatsmenPicker: WKInterfacePicker!
    @IBOutlet var nextScreen: WKInterfaceButton!
    
    let userDefaults = UserDefaults.standard
    
    var batsmenNames = [String]()
    var hasBatted = [Bool]()
    var tempIndex: Int!
    var selectedName = "Select Batsmen"
    
    override func awake(withContext context: Any?) {
        print("in selctBottomBatsmenName")
        nextScreen.setHidden(true)
        hasBatted = userDefaults.array(forKey: "hasBatted") as? [Bool] ?? [Bool]()
        batsmenNames = userDefaults.stringArray(forKey: "battingTeam") ?? []//gets database of all possible batsmen
        bottomBatsmenName.setText(selectedName)//sets text of label
        let capArray = capitalize(array: batsmenNames)//capitalizes all batsmen names
        //sets pickerItems and displays them
        let pickerItems: [WKPickerItem] = capArray.map{
            let pickerItem = WKPickerItem()
            pickerItem.title = $0
            return pickerItem
        }
        bottomBatsmenPicker.setItems(pickerItems)
    }
    
    override func willDisappear() {
        //removes back button
        hasBatted[tempIndex] = true
        userDefaults.setValue(hasBatted, forKey: "hasBatted")
        WKInterfaceController.reloadRootPageControllers(withNames: ["scoreBoardInterface"], contexts: nil, orientation: .horizontal, pageIndex: 0)
    }
    
    
    //gets the value of selected index in picker
    @IBAction func pickerAction(index: Int){
        nextScreen.setHidden(false)
        if(hasBatted[index]){
            bottomBatsmenName.setText("Select Another Batsmen")
            nextScreen.setHidden(true)
        }
        else{
            tempIndex = index
            bottomBatsmenName.setText(batsmenNames[index])//sets the label
            selectedName = batsmenNames[index]
            userDefaults.setValue(selectedName, forKey: "bottomBatsmenName")//saves selected name
            nextScreen.setHidden(false)
        }
    }
    
    //capitalizes all strings in an array
    func capitalize(array: [String] ) -> [String]{
        var tempArray = array
        for (index, element) in tempArray.enumerated(){
            tempArray[index] = element.uppercased()
        }
        return tempArray
    }
}
