//
//  team2PlayersController.swift
//  Scorebook WatchKit Extension
//
//  Created by Chintan Shah on 2020-12-26.
//

import WatchKit
import Foundation


class team2PlayersController: WKInterfaceController {
    @IBOutlet var displayT2PlayersName: WKInterfaceLabel!//displays last entered string
    @IBOutlet var addT2PlayerButton: WKInterfaceButton!//allows user to enter player name
    @IBOutlet var t2DoneButton: WKInterfaceButton!//user presses once finished entering names
    let userDefaults = UserDefaults.standard//storing data permanently
    var sPlayerNames = [String]()
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        sPlayerNames.append("Opposition p1")
        sPlayerNames.append("Opposition p2")
        sPlayerNames.append("Opposition p3")
        sPlayerNames.append("Opposition p4")
        sPlayerNames.append("Opposition p5")
        sPlayerNames.append("Opposition p6")
        sPlayerNames.append("Opposition p7")
        sPlayerNames.append("Opposition p8")
        sPlayerNames.append("Opposition p9")
        sPlayerNames.append("Opposition p10")
        sPlayerNames.append("Opposition p11")
        self.userDefaults.setValue(self.sPlayerNames, forKey: "myKey2")
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }
    
    @IBAction func askForT2Name(){
        self.presentTextInputController(withSuggestions: nil, allowedInputMode:.allowEmoji, completion:{ results in//gets input
            guard let results = results else {return}//return if nil
            OperationQueue.main.addOperation {
                self.dismissTextInputController()
                self.sPlayerNames = self.userDefaults.stringArray(forKey: "myKey2") ?? []//add saved elements to playerNames array
                self.displayT2PlayersName.setText(results[0] as? String)//displays name on label
                self.sPlayerNames.append(results[0] as! String)//adds the name to playerNames array
                self.userDefaults.setValue(self.sPlayerNames, forKey: "myKey2")//saves array to userDefaults
                
            }
        })
    }
    
    @IBAction func printT2PlayerNames(){
        sPlayerNames = userDefaults.stringArray(forKey: "myKey2") ?? []
        print("Team 2 Player Names")
        for index in sPlayerNames{
            print(index)
        }
    }

}
