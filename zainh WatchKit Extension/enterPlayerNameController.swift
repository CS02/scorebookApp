//
//  enterPlayerName.swift
//  Scorebook WatchKit Extension
//
//  Created by Chintan Shah on 2020-12-25.
// Adds Hometeam Player Names

import WatchKit
import Foundation


class enterPlayerNameController: WKInterfaceController {
    
    @IBOutlet var addPlayerButton: WKInterfaceButton!//allows user to enter player name
    @IBOutlet var homeTeamTable: WKInterfaceTable!
    @IBOutlet var doneButton: WKInterfaceButton!
    @IBOutlet var enterHomeTeamName: WKInterfaceButton!
    let myGreen = UIColor(red: 0.0, green: 0.75, blue: 0.0, alpha: 1.0)
    let defaultColor = UIColor(red: (32/255), green: (32/255), blue: (34/255), alpha: 1)
    let userDefaults = UserDefaults.standard//storing data permanently
    var playerNames = [String]()//stores all user inputs
    public var homePlaying11Names = [String]()//stores the names which have been seleected
    var index = 0//counter variable for storing number of rows to display
    
    
    //first thing to run when iterface is called
    override func awake(withContext context: Any?) {
        playerNames = userDefaults.stringArray(forKey: "myKey") ?? []//add saved elements to playerNames array
        homePlaying11Names = userDefaults.stringArray(forKey: "homePlayerNames") ?? []
        finishAddingHomePlayers()//checks if there are enough players to continue
        //if no team name is entered set name to default Name ("home Team")
        let nameOfHomeTeam = userDefaults.string(forKey: "homeTeamName") ?? ""
        if (nameOfHomeTeam.isEmpty){
            userDefaults.setValue("Home Team", forKey: "homeTeamName")
        }
        //displays the players which are already in database
        //sets a green background for players which are selected
        if (playerNames.count > 0){//if there are players in database
            homeTeamTable.setNumberOfRows(playerNames.count, withRowType: "HomeTeamRowController")//sets number of rows to number of players in database
            
            for (element, labelText) in playerNames.enumerated(){//writes player names on labels
                let row = homeTeamTable.rowController(at: element) as? HomeTeamRowController//allows the use of particular row
                row?.homeTeamLabel.setText(labelText)//sets the label of the row to a corosponding  name
                
                if(homePlaying11Names.contains(labelText)){//checks if the name is part of Playing11
                    row?.homeGroup.setBackgroundColor(myGreen)//if it is, set color to green
                }
            }
            self.index = playerNames.count//records the number of rows in table
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }
    
    
    //gets input from user
    //uses input to update table
    @IBAction func askForName(){
        self.presentTextInputController(withSuggestions: nil, allowedInputMode:.allowEmoji, completion:{ results in//gets input
            guard let results = results else {return}//return if nil
            OperationQueue.main.addOperation {
                self.dismissTextInputController()//removes the input controller
                self.playerNames.append(results[0] as! String)//adds input to playerNames array
                self.userDefaults.setValue(self.playerNames, forKey: "myKey")//saves array to userDefaults
                self.homeTeamTable.insertRows(at: [self.index], withRowType: "HomeTeamRowController")//adds a row to table
                let row = self.homeTeamTable.rowController (at: self.index) as! HomeTeamRowController//allows the edit of a row
                row.homeTeamLabel.setText(results[0] as? String)//sets the text of label inside the row to input
                self.index += 1//counts the number of rows
                self.finishAddingHomePlayers()//checks if there are enough players to continue
                
            }
        })
    }
    
    //displays/shows the doneButton according to number of players selected
    func finishAddingHomePlayers (){
        if(homePlaying11Names.count >= 7){//if there are 7 or more players in database
            doneButton.setHidden(false)//show the doneButton
        }
        else{//if there are less than 7 players in database
            doneButton.setHidden(true)//hide the doneButton
        }
        
    }
    
    
    //This func is called when a row in the table is clicked
    //func allows user to select/unselect a player from playing 11 which is stored in homePlaying11Names
    //rowIndex is the index of the row selected
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        
        //Loop iterates over whole array of playerNames
        for element in 0..<playerNames.count{
            let row = homeTeamTable.rowController(at: element) as? HomeTeamRowController//allows use of particular row
            
            //if row was clicked and its name is not in Playing11 (homePlaying11Names)
            //select user
            if(element == rowIndex && !homePlaying11Names.contains(playerNames[element]) && homePlaying11Names.count < 11){
                row?.homeGroup.setBackgroundColor(myGreen)//set background to green
                homePlaying11Names.append(playerNames[element])//add the element to homePlaying11Names
                homePlaying11Names.sort()//sort the array alphabetically
            }
            //if row was clicked and name is already in database
            //unselect user
            else if (element == rowIndex && homePlaying11Names.contains(playerNames[element])){
                row?.homeGroup.setBackgroundColor(defaultColor)//set background to default
                homePlaying11Names.remove(at: homePlaying11Names.firstIndex(of: playerNames[element]) ?? 0)//remove the element from database
            }
            finishAddingHomePlayers()//checks if there are enough players in playing 11
            if (homePlaying11Names.count < 11){
                addPlayerButton.setHidden(false)
            }
            else{
                addPlayerButton.setHidden(true)
            }
        }
        //save the updated playing 11 in userDefaults
        userDefaults.setValue(homePlaying11Names, forKey: "homePlayerNames")
    }
    
    @IBAction func askForHomeTeamName(){
        self.presentTextInputController(withSuggestions: nil, allowedInputMode:.allowEmoji, completion:{ results in//gets input
            guard let results = results else {return}//return if nil
            OperationQueue.main.addOperation {
                self.dismissTextInputController()//removes the input controller
                self.userDefaults.setValue(results[0] as! String, forKey: "homeTeamName")//saves to userDefaults
                self.enterHomeTeamName.setTitle(results[0] as? String)//sets title to input
            }
        })
    }
    
}
