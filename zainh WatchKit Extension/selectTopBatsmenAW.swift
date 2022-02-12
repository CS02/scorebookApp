//
//  selectTopBatsmenAW.swift
//  Scorebook WatchKit Extension
//
//  Created by Chintan Shah on 2021-01-22.
//

import Foundation
import WatchKit

class selectTopBatsmenAW: WKInterfaceController{
    @IBOutlet var topBatsmenName: WKInterfaceLabel!
    @IBOutlet var topBatsmenPicker: WKInterfacePicker!
    @IBOutlet var nextScreen: WKInterfaceButton!
    
    let userDefaults = UserDefaults.standard
    
    var batsmenNames = [String]()
    var hasBatted = [Bool]()
    var tempIndex:Int!
    var selectedName = "Select Batsmen"
    
    override func awake(withContext context: Any?) {
        print("in selectTopBatsmenAW")
        nextScreen.setHidden(true)
        hasBatted = userDefaults.array(forKey: "hasBatted") as? [Bool] ?? [Bool]()
        batsmenNames = userDefaults.stringArray(forKey: "battingTeam") ?? []//gets database of all possible batsmen
        topBatsmenName.setText(selectedName)//sets text of label
        let capArray = capitalize(array: batsmenNames)//capitalizes all batsmen names
        //sets pickerItems and displays them
        let pickerItems: [WKPickerItem] = capArray.map{
            let pickerItem = WKPickerItem()
            pickerItem.title = $0
            return pickerItem
        }
        topBatsmenPicker.setItems(pickerItems)
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
            topBatsmenName.setText("Select Another Batsmen")
            nextScreen.setHidden(true)
        }
        else{
            topBatsmenName.setText(batsmenNames[index])//sets the label
            tempIndex = index
            selectedName = batsmenNames[index]
            userDefaults.setValue(selectedName, forKey: "topBatsmenName")//saves selected name
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
