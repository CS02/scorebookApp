//
//  InterfaceController.swift
//  Scorebook WatchKit Extension
//
//  Created by Chintan Shah on 2020-12-25.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    @IBOutlet var startGameButton: WKInterfaceButton!
    @IBOutlet var editTeamButton: WKInterfaceButton!
    @IBOutlet var statsButton: WKInterfaceButton!
    let userDefaults = UserDefaults.standard//storing data permanently
    
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        removeAllData()
        let numberOfPlayers = userDefaults.stringArray(forKey: "homePlayerNames") ?? []
        if(numberOfPlayers.count >= 7){
            startGameButton.setHidden(false)
        }
        else{
            startGameButton.setHidden(true)
        }
        
        userDefaults.setValue([true,false], forKey: "buttonColorDetails")
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }
    
    func removeAllData(){
        //userDefaults.removeObject(forKey: "homePlayerNames")
        //userDefaults.removeObject(forKey: "myKey")
        //userDefaults.removeObject(forKey: "homeTeamName")
        //userDefaults.removeObject(forKey: "myKey3")
        userDefaults.removeObject(forKey: "Team2Name")
        //userDefaults.removeObject(forKey: "buttonColorDetails")
        userDefaults.removeObject(forKey: "battingTeam")
        userDefaults.removeObject(forKey: "bowlingTeam")
        userDefaults.removeObject(forKey: "numberOfOvers")
        userDefaults.removeObject(forKey: "numberOfOversArray")
        userDefaults.removeObject(forKey: "gameHasStarted")
        userDefaults.removeObject(forKey: "batsmenRuns")
        userDefaults.removeObject(forKey: "batsmenBalls")
        userDefaults.removeObject(forKey: "batsmenFours")
        userDefaults.removeObject(forKey: "batsmenSixes")
        userDefaults.removeObject(forKey: "batsmenDots")
        userDefaults.removeObject(forKey: "batsmenStrikeRate")
        userDefaults.removeObject(forKey: "bowlerRuns")
        userDefaults.removeObject(forKey: "bowlerWickets")
        userDefaults.removeObject(forKey: "bowlerOvers")
        userDefaults.removeObject(forKey: "bowlerEconomy")
        userDefaults.removeObject(forKey: "bowlerExtras")
        userDefaults.removeObject(forKey: "bowlerMaidens")
        userDefaults.removeObject(forKey: "hasBatted")
        userDefaults.removeObject(forKey: "onStrike")
        userDefaults.removeObject(forKey: "totalRuns")
        userDefaults.removeObject(forKey: "totalWickets")
        userDefaults.removeObject(forKey: "totalOvers")
        userDefaults.removeObject(forKey: "currentRunRate")
        userDefaults.removeObject(forKey: "lastBowlerName")
        userDefaults.removeObject(forKey: "topBatsmenName")
        userDefaults.removeObject(forKey: "bottomBatsmenName")
        userDefaults.removeObject(forKey: "bowlerName")
        userDefaults.removeObject(forKey: "extras")
        userDefaults.removeObject(forKey: "history")
        userDefaults.removeObject(forKey: "firstInnings")
    }
    
}
