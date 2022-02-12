//
//  topBatsmen.swift
//  Scorebook WatchKit Extension
//
//  Created by Chintan Shah on 2021-01-08.
//

import Foundation
import WatchKit

class topBatsmen: WKInterfaceController{
    @IBOutlet var topBatsmenName: WKInterfaceLabel!
    @IBOutlet var topBatsmenPicker: WKInterfacePicker!
    @IBOutlet var nextScreen: WKInterfaceButton!
    
    let userDefaults = UserDefaults.standard
    
    var batsmenNames = [String]()
    var hasBatted = [Bool]()
    var tempIndex: Int!
    var selectedName = "Select Batsmen"
    
    override func awake(withContext context: Any?) {
        nextScreen.setHidden(true)
        batsmenNames = userDefaults.stringArray(forKey: "battingTeam") ?? []//gets database of all possible batsmen
        configureData()
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
        //removes back button
        WKInterfaceController.reloadRootPageControllers(withNames: ["bottomBatsmen"], contexts: nil, orientation: .horizontal, pageIndex: 0)
    }
    
    
    //gets the value of selected index in picker
    @IBAction func pickerAction(index: Int){
        nextScreen.setHidden(false)
        tempIndex = index
        topBatsmenName.setText(batsmenNames[index])//sets the label
        selectedName = batsmenNames[index]
        userDefaults.setValue(selectedName, forKey: "topBatsmenName")//saves selected name
    }
    
    //capitalizes all strings in an array
    func capitalize(array: [String] ) -> [String]{
        var tempArray = array
        for (index, element) in tempArray.enumerated(){
            tempArray[index] = element.uppercased()
        }
        return tempArray
    }
    
    func configureData(){
        for _ in 0..<batsmenNames.count{
            hasBatted.append(false)
        }
        userDefaults.setValue(hasBatted, forKey: "hasBatted")
    }
}
