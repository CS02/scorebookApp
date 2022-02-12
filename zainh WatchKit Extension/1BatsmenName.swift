//
//  1BatsmenName.swift
//  Scorebook WatchKit Extension
//
//  Created by Chintan Shah on 2021-01-08.
//
import WatchKit
import Foundation

class batsmen1Name: WKInterfaceController{
    
    @IBOutlet var batsmen1Name: WKInterfaceLabel!
    @IBOutlet var nextController: WKInterfaceButton!
    @IBOutlet var batsmen1Picker: WKInterfacePicker!
    
    let userDefaults = UserDefaults.standard
    var homeTeamNames = [String]()
    var homePlayerHasBatted = [Bool]()
    
    
    override func awake(withContext context: Any?) {
        homeTeamNames = userDefaults.stringArray(forKey: "homePlayerNames") ?? []
        let pickerItems: [WKPickerItem] = homeTeamNames.map{
            if(true){
                let pickerItem = WKPickerItem()
                pickerItem.title = $0
                return pickerItem
            }
        }
        batsmen1Picker.setItems(pickerItems)
    }
    
    override func didDeactivate() {
        
    }
    
    @IBAction func pickerAction(index: Int){
        batsmen1Name.setText(homeTeamNames[index])
       // nextController.setHidden(false)
        
    }

}
