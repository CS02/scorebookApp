//
//  selectHomeTeamPlayers.swift
//  Scorebook WatchKit Extension
//
//  Created by Chintan Shah on 2020-12-25.
//

import WatchKit
import Foundation


class selectHomeTeamPlayers: WKInterfaceController {
    @IBOutlet var myTable: WKInterfaceTable!
    var homeTeamPlayerNames = enterPlayerNameController()
    var t2PlayerNames = team2PlayersController()
    
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
        var x = 0
        myTable.setNumberOfRows(homeTeamPlayerNames.playerNames.count, withRowType: "cell")
        
        for index in homeTeamPlayerNames.playerNames{
            let row = myTable.rowController(at: x) as! selectPlayerNameRowController
            row.mylable.setText(index)
            x += 1
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }
    
}
