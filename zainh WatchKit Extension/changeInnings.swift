//
//  changeInnings.swift
//  Scorebook WatchKit Extension
//
//  Created by Chintan Shah on 2021-01-29.
//

import Foundation
import WatchKit
class changeInnings: WKInterfaceController{
    
    @IBOutlet var b1:WKInterfaceButton!
    @IBOutlet var b2:WKInterfaceButton!
    
    override func didAppear() {
        Thread.sleep(forTimeInterval: 2)
        pushController(withName: "topBatsmen", context: nil)
        WKInterfaceController.reloadRootPageControllers(withNames: ["topBatsmen"], contexts: nil, orientation: .horizontal, pageIndex: 0)
    }
}
