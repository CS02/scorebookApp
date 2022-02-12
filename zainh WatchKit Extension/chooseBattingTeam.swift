//
//  chooseBattingTeam.swift
//  Scorebook WatchKit Extension
//
//  Created by Chintan Shah on 2021-01-04.
//

import WatchKit
import Foundation

class chooseBattingTeam: WKInterfaceController{
    
    @IBOutlet var homeTeamBatsFirst: WKInterfaceButton!
    @IBOutlet var team2BatsFirst: WKInterfaceButton!
    @IBOutlet var textLabel: WKInterfaceLabel!
    
    let userDefaults = UserDefaults.standard//stores data permanently
    
    var selected = [true, false]//stores the selected team
    static let myGreen = UIColor(red: 0.0, green: 0.75, blue: 0.0, alpha: 1.0)
    static let defaultColor = UIColor(red: (32/255), green: (32/255), blue: (34/255), alpha: 1)
    
    
    override func awake(withContext context: Any?) {
        //when controller is first called
        homeTeamBatsFirst.setTitle(userDefaults.string(forKey: "homeTeamName"))
        team2BatsFirst.setTitle(userDefaults.string(forKey: "Team2Name"))
        selected = userDefaults.array(forKey: "buttonColorDetails") as? [Bool] ?? [Bool]()//set values for selected
        //if the homeTeam is selected
        //responsible for coloring the selected team
        if (selected[0]){
            team2BatsFirst.setBackgroundColor(chooseBattingTeam.defaultColor)//make team2BatsFirst button green
            homeTeamBatsFirst.setBackgroundColor(chooseBattingTeam.myGreen)// make homeTeamBatsFirst default color
        }
        //if other team is selected
        else{
            team2BatsFirst.setBackgroundColor(chooseBattingTeam.myGreen)//make team2BatsFirst button green
            homeTeamBatsFirst.setBackgroundColor(chooseBattingTeam.defaultColor)// make homeTeamBatsFirst default color
        }
    }
    
    override func willActivate() {
        //when controller is about to activate
    }
    
    override func willDisappear() {
        WKInterfaceController.reloadRootPageControllers(withNames: ["oversNumberPad"], contexts: nil, orientation: .horizontal, pageIndex: 0)
    }
    
    override func didDeactivate() {
        //when controller is deactivated
        userDefaults.setValue(selected, forKey: "buttonColorDetails")//update key remember until next time
        
        if (selected[0]){//if home team is batting
            //store the names of homeTeam in battingTeam
            let battingTeam = userDefaults.stringArray(forKey: "homePlayerNames")
            userDefaults.setValue(battingTeam, forKey: "battingTeam")
            //store the names of team2 in bowlingTeam
            let bowlingTeam = userDefaults.stringArray(forKey: "myKey3")
            userDefaults.setValue(bowlingTeam, forKey: "bowlingTeam")
            
            let battingFirstTeamName = userDefaults.string(forKey: "homeTeamName")
            let battingSecondTeamName = userDefaults.string(forKey: "Team2Name")
            userDefaults.setValue(battingFirstTeamName, forKey: "battingFirstTeamName")
            userDefaults.setValue(battingSecondTeamName, forKey: "battingSecondTeamName")
        }
        else{//if team2 is batting
            //store the names of team2 in battingTeam
            let battingTeam = userDefaults.stringArray(forKey: "myKey3")
            userDefaults.setValue(battingTeam, forKey: "battingTeam")
            //store the names of homeTeam in bowlingTeam
            let bowlingTeam = userDefaults.stringArray(forKey: "homePlayerNames")
            userDefaults.setValue(bowlingTeam, forKey: "bowlingTeam")
            
            let battingFirstTeamName = userDefaults.string(forKey: "Team2Name")
            let battingSecondTeamName = userDefaults.string(forKey: "homeTeamName")
            userDefaults.setValue(battingFirstTeamName, forKey: "battingFirstTeamName")
            userDefaults.setValue(battingSecondTeamName, forKey: "battingSecondTeamName")
        }
    }
    
    @IBAction func homeTeamSelected(){
        setButtonColors(index: 0)
    }
    
    @IBAction func team2Selected(){
        setButtonColors(index: 1)
    }
    
    func setButtonColors(index: Int){
        if(index == 0  && !selected[0]){//if home team is selected
            team2BatsFirst.setBackgroundColor(chooseBattingTeam.defaultColor)//make team2BatsFirst button default color
            homeTeamBatsFirst.setBackgroundColor(chooseBattingTeam.myGreen)// make homeTeamBatsFirst green
            //switch values of teams batting first
            selected[0] = true
            selected[1] = false
        }
        else if(index == 1 && !selected[1]){//if team2 is selected
            team2BatsFirst.setBackgroundColor(chooseBattingTeam.myGreen)//make team2BatsFirst button green
            homeTeamBatsFirst.setBackgroundColor(chooseBattingTeam.defaultColor)// make homeTeamBatsFirst default color
            //switch values of teams batting first
            selected[0] = false
            selected[1] = true
        }
        
    }
    
}
