//
//  bottomBatsmen.swift
//  Scorebook WatchKit Extension
//
//  Created by Chintan Shah on 2021-01-09.
//

import Foundation
import WatchKit

class bottomBatsmen: WKInterfaceController{
    @IBOutlet var bottomBatsmenName: WKInterfaceLabel!
    @IBOutlet var bottomBatsmenPicker: WKInterfacePicker!
    @IBOutlet var nextScreen: WKInterfaceButton!
    
    let userDefaults = UserDefaults.standard
    
    var batsmenNames = [String]()
    var tempIndex: Int!
    var hasBatted = [Bool]()
    var selectedName = "Select Batsmen"
    
    override func awake(withContext context: Any?) {
        nextScreen.setHidden(true)
        hasBatted = userDefaults.array(forKey: "hasBatted") as? [Bool] ?? [Bool]()
        batsmenNames = userDefaults.stringArray(forKey: "battingTeam") ?? []//gets all possible batsmen from database
        bottomBatsmenName.setText(selectedName)//sets label
        let capArray = capitalize(array: batsmenNames)//capitalizes all strings in array
        
        //sets the items for the picker
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
        WKInterfaceController.reloadRootPageControllers(withNames: ["bowler"], contexts: nil, orientation: .horizontal, pageIndex: 0)
    }
    
    //gets the selected value from picker
    @IBAction func bottomBatsmenPicker(index: Int){
        nextScreen.setHidden(false)
        if(hasBatted[index]){
            bottomBatsmenName.setText("Select Another Batsmen")
            nextScreen.setHidden(true)
        }
        else{
            bottomBatsmenName.setText(batsmenNames[index])//sets the label
            tempIndex = index
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
