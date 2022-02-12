//
//  oversNumberPad.swift
//  Scorebook WatchKit Extension
//
//  Created by Chintan Shah on 2021-01-05.
//

import Foundation
import WatchKit

class oversNumberPad: WKInterfaceController {
    
    @IBOutlet var one: WKInterfaceButton!
    @IBOutlet var two: WKInterfaceButton!
    @IBOutlet var three: WKInterfaceButton!
    @IBOutlet var four: WKInterfaceButton!
    @IBOutlet var five: WKInterfaceButton!
    @IBOutlet var six: WKInterfaceButton!
    @IBOutlet var seven: WKInterfaceButton!
    @IBOutlet var eight: WKInterfaceButton!
    @IBOutlet var nine: WKInterfaceButton!
    @IBOutlet var zero: WKInterfaceButton!
    @IBOutlet var delete: WKInterfaceButton!
    @IBOutlet var next: WKInterfaceButton!
    @IBOutlet var displayNumbers: WKInterfaceLabel!
    
    static var overs:Int = 0
    var numArray: [Int] = []
    
    var userDefaults = UserDefaults.standard//stores data permanently
    
    override func awake(withContext context: Any?) {
        displayNumbers.setText("How Many Overs?")
    }
    
    override func willActivate() {
        oversNumberPad.overs = userDefaults.integer(forKey: "numberOfOvers")
        numArray = userDefaults.array(forKey: "numberOfOversArray") as? [Int] ?? [Int]()
        if(!numArray.isEmpty){
            updateInfo()
        }
        
    }
    
    override func willDisappear() {
        //removes back button
        oversNumberPad.overs = numArray.reduce(0){return $0*10 + $1}
        userDefaults.setValue(oversNumberPad.overs, forKey: "numberOfOvers")
        userDefaults.setValue(numArray, forKey: "numberOfOversArray")
        userDefaults.setValue(true, forKey: "firstInnings")
        WKInterfaceController.reloadRootPageControllers(withNames: ["topBatsmen"], contexts: nil, orientation: .horizontal, pageIndex: 0)
    }
    
    
    @IBAction func addOne(){
        numArray.append(1)
        updateInfo()
    }
    
    @IBAction func addTwo(){
        numArray.append(2)
        updateInfo()
    }
    
    @IBAction func addThree(){
        numArray.append(3)
        updateInfo()
    }
    
    @IBAction func addFour(){
        numArray.append(4)
        updateInfo()
    }
    
    @IBAction func addFive(){
        numArray.append(5)
        updateInfo()
    }
    
    @IBAction func addSix(){
        numArray.append(6)
        updateInfo()
    }
    
    @IBAction func addSeven(){
        numArray.append(7)
        updateInfo()
    }
    
    @IBAction func addEight(){
        numArray.append(8)
        updateInfo()
    }
    
    @IBAction func addNine(){
        numArray.append(9)
        updateInfo()
    }
    
    @IBAction func addZero(){
        numArray.append(0)
        updateInfo()
    }
    
    @IBAction func deleteLast(){
        numArray.removeLast()
        updateInfo()
    }
    
    
    func updateInfo(){
        let labelText = (numArray.map{String($0)}).joined()
        displayNumbers.setText(labelText)
        next.setHidden(false)
        
        if(!numArray.isEmpty && numArray[0] > 0){
            next.setHidden(false)
        }

        else{
            next.setHidden(true)
        }
        
    }
    
    
}
