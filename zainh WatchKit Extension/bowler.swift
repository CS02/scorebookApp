//
//  bowler.swift
//  Scorebook WatchKit Extension
//
//  Created by Chintan Shah on 2021-01-09.
//

import Foundation
import WatchKit

class bowler: WKInterfaceController{
    @IBOutlet var bowlerNameLabel: WKInterfaceLabel!
    @IBOutlet var bowlerPicker: WKInterfacePicker!
    @IBOutlet var nextScreen: WKInterfaceButton!
    
    let userDefaults = UserDefaults.standard
    
    var bowlerNames = [String]()
    var selectedName = "Select Bowler"
    var lastBowlerName: String!
    
    override func awake(withContext context: Any?) {
        lastBowlerName = userDefaults.string(forKey: "lastBowlerName")//gets the name of the last bowler
        
        if(selectedName == "Select Bowler"){
            nextScreen.setHidden(true)
        }
        
        bowlerNames = userDefaults.stringArray(forKey: "bowlingTeam") ?? []//gets all possible batsmen from database
        bowlerNameLabel.setText(selectedName)//sets label
        let capArray = capitalize(array: bowlerNames)//capitalizes all strings in array
        
        //sets the items for the picker
        let pickerItems: [WKPickerItem] = capArray.map{
            let pickerItem = WKPickerItem()
            pickerItem.title = $0
            return pickerItem
        }
        bowlerPicker.setItems(pickerItems)
    }
    
    override func willDisappear() {
        //removes back button
        WKInterfaceController.reloadRootPageControllers(withNames: ["scoreBoardInterface"], contexts: nil, orientation: .horizontal, pageIndex: 0)
    }
        
    @IBAction func bowlerPickerAction(index: Int){
        //doesn't allow same bowler to bowl twice in a row
        if(lastBowlerName == bowlerNames[index]){
            nextScreen.setHidden(true)
            bowlerNameLabel.setText("Select Another Bowler")
        }
        else{
            nextScreen.setHidden(false)
            bowlerNameLabel.setText(bowlerNames[index])//sets label
            selectedName = bowlerNames[index]
            userDefaults.setValue(selectedName, forKey: "bowlerName")//saves the selected batsmenName
        }
    }
    
    func capitalize(array: [String] ) -> [String]{
        var tempArray = array
        for (index, element) in tempArray.enumerated(){
            tempArray[index] = element.uppercased()
        }
        return tempArray
    }
    
}
