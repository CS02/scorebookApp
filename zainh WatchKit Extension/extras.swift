//
//  extras.swift
//  Scorebook WatchKit Extension
//
//  Created by Chintan Shah on 2021-01-20.
//

import Foundation
import WatchKit

class extras: WKInterfaceController{
    @IBOutlet var lastScreen: WKInterfaceButton!
    @IBOutlet var extraPicker: WKInterfacePicker!
    @IBOutlet var extraLabel: WKInterfaceLabel!
    
    @IBOutlet var yesButton: WKInterfaceButton!
    @IBOutlet var noButton: WKInterfaceButton!
    
    var extraOptions = ["0", "1", "2", "3", "4", "5", "6", "7"]
    var extras = 0
    
    let userDefaults = UserDefaults.standard
    
    var bowlerRuns = [Int]()
    var totalRuns: Int!
    var bowlerExtras = [Int]()
    var onStrike = [Bool]()
    
    
    
    override func awake(withContext context: Any?) {
        getRequiredData()
        let pickerItems: [WKPickerItem] = extraOptions.map{
            let pickerItem = WKPickerItem()
            pickerItem.title = $0
            return pickerItem
        }
        extraPicker.setItems(pickerItems)
        
        extraLabel.setText(String(extras))
        
        noButton.setBackgroundColor(chooseBattingTeam.myGreen)
        yesButton.setBackgroundColor(chooseBattingTeam.defaultColor)
        
        lastScreen.setHidden(true)
    }
    
    override func willDisappear() {
        bowlerRuns[scoreBoard.bowlerIndex] += extras
        bowlerExtras[scoreBoard.bowlerIndex] += extras
        totalRuns += extras
        
        userDefaults.setValue(bowlerRuns, forKey: "bowlerRuns")
        userDefaults.setValue(bowlerExtras, forKey: "bowlerExtras")
        userDefaults.setValue(totalRuns, forKey: "totalRuns")
        userDefaults.setValue(onStrike, forKey: "onStrike")
        //removes back button
        WKInterfaceController.reloadRootPageControllers(withNames: ["scoreBoardInterface"], contexts: nil, orientation: .horizontal, pageIndex: 0)
        
    }
    
    @IBAction func pickerAction(index: Int){
        lastScreen.setHidden(false)
        extras = index
        extraLabel.setText(String(extras))
    }
    
    func getRequiredData(){
        bowlerRuns = userDefaults.array(forKey: "bowlerRuns") as? [Int] ?? [Int]()
        bowlerExtras = userDefaults.array(forKey: "bowlerExtras") as? [Int] ?? [Int]()
        totalRuns = userDefaults.integer(forKey: "totalRuns")
        onStrike = userDefaults.array(forKey: "onStrike") as? [Bool] ?? [Bool]()
    }
    
    @IBAction func yesAction(){
        yesButton.setBackgroundColor(chooseBattingTeam.myGreen)
        noButton.setBackgroundColor(chooseBattingTeam.defaultColor)
        onStrike[0] = !onStrike[0]
        onStrike[1] = !onStrike[1]
    }
    
    @IBAction func noAction(){
        noButton.setBackgroundColor(chooseBattingTeam.myGreen)
        yesButton.setBackgroundColor(chooseBattingTeam.defaultColor)
        onStrike[0] = !onStrike[0]
        onStrike[1] = !onStrike[1]
        
    }
    
}
