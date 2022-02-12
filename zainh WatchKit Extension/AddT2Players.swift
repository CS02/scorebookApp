//
//  TableTest.swift
//  Scorebook WatchKit Extension
//
//  Created by Chintan Shah on 2020-12-31.
//
import WatchKit
import Foundation
import UIKit


class AddT2Players: WKInterfaceController {

    @IBOutlet weak var myTable: WKInterfaceTable!
    @IBOutlet var addT2PlayerButton: WKInterfaceButton!
    @IBOutlet var t2DoneButton: WKInterfaceButton!
    @IBOutlet var enterTeam2Name: WKInterfaceButton!
    let userDefaults = UserDefaults.standard//storing data permanently
    var t2PlayerNames = [String]()
    var t2Index = 0
    
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
        userDefaults.removeObject(forKey: "myKey3")//config help
        t2PlayerNames = userDefaults.stringArray(forKey: "myKey3") ?? []//add saved elements to playerNames array
        /*
        t2PlayerNames.append("David")//config help
        t2PlayerNames.append("Marcus")
        t2PlayerNames.append("Marnus")
        t2PlayerNames.append("Smith")
        t2PlayerNames.append("Matthew")
        t2PlayerNames.append("Green")
        t2PlayerNames.append("Tim")
        t2PlayerNames.append("Pat")
        t2PlayerNames.append("Mitchell")
        t2PlayerNames.append("Nathon")
 */
        //t2PlayerNames.append("Josh")//config help
        //if no team name is entered set name to default Name ("Team 2")
        if ((userDefaults.string(forKey: "Team2Name") ?? "").isEmpty){
            userDefaults.setValue("Team 2", forKey: "Team2Name")
        }
        finishAddingT2Players()
        if (t2PlayerNames.count > 0){
            myTable.setNumberOfRows(t2PlayerNames.count, withRowType: "T2RowController")
            for (element, labelText) in t2PlayerNames.enumerated(){
                let row = myTable.rowController(at: element) as? T2RowController
                row?.myLabel.setText(labelText)
                self.t2Index = t2PlayerNames.count
            }
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user

    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        userDefaults.setValue(t2PlayerNames, forKey: "myKey3")
    }
    
    @IBAction func askT2Names(){
        if(t2PlayerNames.count < 11){
            self.presentTextInputController(withSuggestions: nil, allowedInputMode:.allowEmoji, completion:{ results in//gets input
                guard let results = results else {return}//return if nil
                OperationQueue.main.addOperation {
                    self.dismissTextInputController()
                    self.t2PlayerNames.append(results[0] as! String)//adds the name to playerNames array
                    self.userDefaults.setValue(self.t2PlayerNames, forKey: "myKey3")//saves array to userDefaults
                    self.myTable.insertRows(at: [self.t2Index], withRowType: "T2RowController")
                    let row = self.myTable.rowController (at: self.t2Index) as! T2RowController
                    row.myLabel.setText(results[0] as? String)
                    self.t2Index += 1
                    self.finishAddingT2Players()
                }
            })
        }
    }
    
    func finishAddingT2Players(){
        if(t2PlayerNames.count == 11){
            addT2PlayerButton.setHidden(true)
        }
        
        if(t2PlayerNames.count >= 7){//if there are 7 or more players in database
            t2DoneButton.setHidden(false)//show the doneButton
        }
        else{//if there are less than 7 players in database
            t2DoneButton.setHidden(true)//hide the doneButton
        }
        
    }
    
    @IBAction func askForTeam2Name(){
        self.presentTextInputController(withSuggestions: nil, allowedInputMode:.allowEmoji, completion:{ results in//gets input
            guard let results = results else {return}//return if nil
            OperationQueue.main.addOperation {
                self.dismissTextInputController()//removes the input controller
                self.userDefaults.setValue(results[0] as! String, forKey: "Team2Name")//saves to userDefaults
                self.enterTeam2Name.setTitle(results[0] as? String)//sets title to input
            }
        })
    }
    
}
