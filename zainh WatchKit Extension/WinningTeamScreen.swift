//
//  WinningTeamScreen.swift
//  Scorebook WatchKit Extension
//
//  Created by Chintan Shah on 2021-01-26.
//

import Foundation
import WatchKit

class WinningTeamScreen: WKInterfaceController{
    @IBOutlet var  WinningTeamLabel: WKInterfaceLabel!
    @IBOutlet var emoji: WKInterfaceLabel!
    let userDefaults = UserDefaults.standard
    override func awake(withContext context: Any?) {
        let homeTeamName = userDefaults.string(forKey: "homeTeamName")
        let winningTeamName = userDefaults.string(forKey: "winningTeamName")
        if(winningTeamName == homeTeamName){
            emoji.setText("🥳")
        }
        else{
            emoji.setText("😥")
        }
        WinningTeamLabel.setText(winningTeamName)
    }
}
