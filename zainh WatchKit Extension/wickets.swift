//
//  wickets.swift
//  Scorebook WatchKit Extension
//
//  Created by Chintan Shah on 2021-01-21.
//

import Foundation
import WatchKit

class wickets: WKInterfaceController{
    
    @IBOutlet var topBatsmenOut: WKInterfaceButton!
    @IBOutlet var bottomBatsmenOut: WKInterfaceButton!
    @IBOutlet var howOutPicker: WKInterfacePicker!
    @IBOutlet var howOutLabel: WKInterfaceLabel!
    @IBOutlet var doneTopBatsmenOut: WKInterfaceButton!
    @IBOutlet var doneBottomeBatsmenOut: WKInterfaceButton!
    
    var howOutOptions: [String] = ["RunOut", "Bowled", "Caught", "LBW", "Retired"]
    var bowlerWickets = [Int]()
    var totalWickets: Int!
    var totalOvers: Double!
    static var howOutTempIndex: Int!
    
    var userDefaults = UserDefaults.standard
    
    override func awake(withContext context: Any?) {
        topBatsmenOut.setTitle(scoreBoard.topBatsmenName)
        bottomBatsmenOut.setTitle(scoreBoard.bottomBatsmenName)
        
        doneTopBatsmenOut.setHidden(true)
        doneBottomeBatsmenOut.setHidden(true)
        
        //sets the items for the picker
        let pickerItems: [WKPickerItem] = howOutOptions.map{
            let pickerItem = WKPickerItem()
            pickerItem.title = $0
            return pickerItem
        }
        howOutPicker.setItems(pickerItems)
    }
    
    override func willDisappear() {
        totalWickets = userDefaults.integer(forKey: "totalWickets")
        //if the batsmen got bowled, caught or lbw add wickets to score and bowler
        if(wickets.howOutTempIndex != 0 && wickets.howOutTempIndex != 4 && wickets.howOutTempIndex != nil){
            bowlerWickets = userDefaults.array(forKey: "bowlerWickets") as? [Int] ?? [Int]()
            bowlerWickets[scoreBoard.bowlerIndex] += 1
            userDefaults.setValue(bowlerWickets, forKey: "bowlerWickets")
            totalWickets += 1
        }
        //if the batsmen got runout or retired
        else{
            totalWickets += 1
        }
        
        userDefaults.setValue(totalWickets, forKey: "totalWickets")
        
        //removes back button
        WKInterfaceController.reloadRootPageControllers(withNames: ["selectTopBatsmenAW", "selectBottomBatsmenAW"], contexts: nil, orientation: .horizontal, pageIndex: 0)
        //removes back button
        //WKInterfaceController.reloadRootPageControllers(withNames: ["selectBottomBatsmenAW"], contexts: nil, orientation: .horizontal, pageIndex: 0)

    }
    
    @IBAction func getTopBatsmenOut (){
        topBatsmenOut.setBackgroundColor(chooseBattingTeam.myGreen)
        bottomBatsmenOut.setBackgroundColor(chooseBattingTeam.defaultColor)
        doneTopBatsmenOut.setHidden(false)
        doneBottomeBatsmenOut.setHidden(true)
    }
    
    @IBAction func getBottomBatsmenOut(){
        topBatsmenOut.setBackgroundColor(chooseBattingTeam.defaultColor)
        bottomBatsmenOut.setBackgroundColor(chooseBattingTeam.myGreen)
        doneTopBatsmenOut.setHidden(true)
        doneBottomeBatsmenOut.setHidden(false)
    }
    
    @IBAction func PickerAction(index: Int){
        wickets.howOutTempIndex = index
        howOutLabel.setText(howOutOptions[index])
    }
    
}
