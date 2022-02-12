//
//  scoreBoard.swift
//  Scorebook WatchKit Extension
//
//  Created by Chintan Shah on 2021-01-06.
//

import WatchKit
import Foundation

class scoreBoard: WKInterfaceController{
    
    @IBOutlet var dotBall: WKInterfaceButton!
    @IBOutlet var oneRun: WKInterfaceButton!
    @IBOutlet var twoRuns: WKInterfaceButton!
    @IBOutlet var threeRuns: WKInterfaceButton!
    @IBOutlet var fourRuns: WKInterfaceButton!
    @IBOutlet var sixRuns: WKInterfaceButton!
    @IBOutlet var extras: WKInterfaceButton!
    @IBOutlet var wicket: WKInterfaceButton!
    @IBOutlet var other: WKInterfaceButton!
    
    @IBOutlet var imageOne: WKInterfaceImage!
    @IBOutlet var imageTwo: WKInterfaceImage!
    @IBOutlet var imageThree: WKInterfaceImage!
    @IBOutlet var imageFour: WKInterfaceImage!
    @IBOutlet var imageFive: WKInterfaceImage!
    @IBOutlet var imageSix: WKInterfaceImage!
    @IBOutlet var topOnStrike: WKInterfaceImage!
    @IBOutlet var bottomOnStrike: WKInterfaceImage!
    
    @IBOutlet var score: WKInterfaceLabel!
    @IBOutlet var totalOversLabel: WKInterfaceLabel!
    @IBOutlet var bat1Name: WKInterfaceLabel!
    @IBOutlet var bat2Name: WKInterfaceLabel!
    @IBOutlet var bat1Runs: WKInterfaceLabel!
    @IBOutlet var bat1Balls: WKInterfaceLabel!
    @IBOutlet var bat2Runs: WKInterfaceLabel!
    @IBOutlet var bat2Balls: WKInterfaceLabel!
    @IBOutlet var bowlerNameLabel: WKInterfaceLabel!
    @IBOutlet var bowlerRunsLabel: WKInterfaceLabel!
    @IBOutlet var bowlerOversLabel: WKInterfaceLabel!
    
    @IBOutlet var separator1: WKInterfaceSeparator!
    @IBOutlet var separator2: WKInterfaceSeparator!
    @IBOutlet var separator3: WKInterfaceSeparator!
    @IBOutlet var separator4: WKInterfaceSeparator!
    @IBOutlet var separator5: WKInterfaceSeparator!
    
    @IBOutlet var batsmenSGR: WKGestureRecognizer!
    @IBOutlet var batsmenSGL: WKGestureRecognizer!
    @IBOutlet var bowlerSGR: WKGestureRecognizer!
    @IBOutlet var bolwerSGL: WKGestureRecognizer!
    @IBOutlet var batsmenRSR4: WKInterfaceLabel!
    @IBOutlet var batsmenBD6: WKInterfaceLabel!
    @IBOutlet var bowlerRWE: WKInterfaceLabel!
    @IBOutlet var bowlerOEM: WKInterfaceLabel!
    
    @IBOutlet var scoreOversGroup: WKInterfaceGroup!
    @IBOutlet var sep1: WKInterfaceSeparator!
    @IBOutlet var batInfoGroup: WKInterfaceGroup!
    @IBOutlet var sep2: WKInterfaceSeparator!
    @IBOutlet var bowlInfoGroup: WKInterfaceGroup!
    @IBOutlet var sep3: WKInterfaceSeparator!
    @IBOutlet var historyGroup: WKInterfaceGroup!
    @IBOutlet var zero12Group: WKInterfaceGroup!
    @IBOutlet var three45Group: WKInterfaceGroup!
    @IBOutlet var extraWOGroup: WKInterfaceGroup!
    
    
    let userDefaults = UserDefaults.standard
    
    var gameHasStarted: Bool!
    var firstInnings: Bool!
    
    var totalRuns: Int!
    var totalWickets: Int!
    static var topbatsmenIndex: Int!
    static var bottomBatsmenIndex: Int!
    static var bowlerIndex: Int!
    var scoreBeforeOver: Int!
    var runsTarget: Int!
    
    var totalOvers: Double!
    var currentRunRate: Double!
    
    static var topBatsmenName: String!
    static var bottomBatsmenName: String!
    static var bowlerName: String!
    
    
    var hasBatted = [Bool]()
    var onStrike = [Bool]()
    
    var batsmenRuns = [Int]()
    var batsmenBalls = [Int]()
    var batsmenFours = [Int]()
    var batsmenSixes = [Int]()
    var batsmenDots = [Int]()
    var bowlerRuns = [Int]()
    var bowlerWickets = [Int]()
    var bowlerExtras = [Int]()
    var bowlerMaidens = [Int]()
    
    var history = [Int]()
    
    
    var batsmenStrikeRate = [Int]()
    var bowlerOvers = [Double]()
    var bowlerEconomy = [Double]()
    
    var HomeTeamPlayers = [String]()
    var Team2Players = [String]()
    var battingTeam = [String]()
    var bowlingTeam = [String]()
    
    var currentBatsmenScreen = 1
    var currentBowlerScreen = 1
    
    var tempTest : Int!
    
    let smallRunColor = UIColor.init(red: 0.59, green: 0.90, blue: 0.46, alpha: 1)
    let threeRunColor = UIColor.init(red: 0.33, green: 0.78, blue: 0.14, alpha: 1.0)
    let bigRunColor = UIColor.init(red: 0.07, green: 0.78, blue: 0.08, alpha: 1.0)
    let extrasColor = UIColor.init(red: 1.00, green: 0.66, blue: 0.0, alpha: 1.0)
    let wicketsColor = UIColor.init(red: 0.89, green: 0.01, blue: 0.01, alpha: 1.0)
    let otherColor = UIColor.init(red: 0.91, green: 0.37, blue: 0.91, alpha: 1.0)
    
    
    override func awake(withContext context: Any?) {
        //when controller is shown
        firstInnings = userDefaults.bool(forKey: "firstInnings")
        gameHasStarted = userDefaults.bool(forKey: "gameHasStarted")
        // if game has not started then setuop
        if(gameHasStarted == nil || !gameHasStarted) {
            setup()
        }
        
        initialize()//read and write saved data
        showScoreBoard()//display scoreboard
    }
    
    override func didDeactivate() {
        //when controller is deactivated
    }
    
    override func willActivate() {

    }
    
    override func willDisappear() {
        saveToUserDefaults()
    }
    
    @IBAction func zeroRunInput(){
        batsmenDots[getBatsmenOnStrikeIndex()] += 1
        changeHistory(imageType: 0)
        simpleGameInput(runs: 0)
        
    }
    
    @IBAction func oneRunInput(){
        changeHistory(imageType: 1)
        simpleGameInput(runs: 1)
        
    }
    
    @IBAction func twoRunInput(){
        changeHistory(imageType: 2)
        simpleGameInput(runs: 2)
    }
    
    @IBAction func threeRunInput(){
        changeHistory(imageType: 3)
        simpleGameInput(runs: 3)
    }
    
    @IBAction func fourRunInput(){
        batsmenFours[getBatsmenOnStrikeIndex()] += 1
        changeHistory(imageType: 4)
        simpleGameInput(runs: 4)
        
    }
    
    @IBAction func sixRunInput(){
        batsmenSixes[getBatsmenOnStrikeIndex()] += 1
        changeHistory(imageType: 6)
        simpleGameInput(runs: 6)
        
    }
    
    @IBAction func extrasInput(){
        changeHistory(imageType: 7)
        pushController(withName: "extras", context: nil)
        WKInterfaceController.reloadRootPageControllers(withNames: ["extras"], contexts: nil, orientation: .horizontal, pageIndex: 0)
        checkForEnd()
    }
    
    @IBAction func wicketInput(){
        changeHistory(imageType: 8)
        changeOvers()
        setBowlerEconomy()
        checkForEnd()
        pushController(withName: "Wickets", context: nil)
        WKInterfaceController.reloadRootPageControllers(withNames: ["Wickets"], contexts: nil, orientation: .horizontal, pageIndex: 0)
    }
    
    @IBAction func otherInput(){
        print("other")
    }
    
    //when game is started for very first time
    func setup(){
        totalRuns = 0
        totalWickets = 0
        totalOvers = 0.0
        currentRunRate = 0.0
        scoreBeforeOver = 0
        gameHasStarted = true
        userDefaults.setValue(gameHasStarted, forKey: "gameHasStarted")
        userDefaults.setValue(totalOvers, forKey: "totalOvers")
        
        topOnStrike.setHidden(false)
        bottomOnStrike.setHidden(true)

        HomeTeamPlayers = userDefaults.stringArray(forKey: "homePlayerNames") ?? []
        Team2Players = userDefaults.stringArray(forKey: "myKey3") ?? []
        battingTeam = userDefaults.stringArray(forKey: "battingTeam") ?? []
        bowlingTeam = userDefaults.stringArray(forKey: "bowlingTeam") ?? []
        
        
        
        
        //setup data for batting Team
        for _ in 0..<battingTeam.count{
            batsmenRuns.append(0)
            batsmenBalls.append(0)
            batsmenFours.append(0)
            batsmenSixes.append(0)
            batsmenDots.append(0)
            batsmenStrikeRate.append(0)
            //hasBatted.append(false)

        }
        
        //setupData for BowlingTeam
        for _ in 0..<bowlingTeam.count{
            bowlerRuns.append(0)
            bowlerWickets.append(0)
            bowlerOvers.append(0)
            bowlerEconomy.append(0)
            bowlerExtras.append(0)
            bowlerMaidens.append(0)
        }
        
        //save all data in userDefaults
        userDefaults.setValue(batsmenRuns, forKey: "batsmenRuns")
        userDefaults.setValue(batsmenBalls, forKey: "batsmenBalls")
        userDefaults.setValue(batsmenFours, forKey: "batsmenFours")
        userDefaults.setValue(batsmenSixes, forKey: "batsmenSixes")
        userDefaults.setValue(batsmenDots, forKey: "batsmenDots")
        userDefaults.setValue(batsmenStrikeRate, forKey: "batsmenStrikeRate")
        
        userDefaults.setValue(bowlerRuns, forKey: "bowlerRuns")
        userDefaults.setValue(bowlerWickets, forKey: "bowlerWickets")
        userDefaults.setValue(bowlerOvers, forKey: "bowlerOvers")
        userDefaults.setValue(bowlerEconomy, forKey: "bowlerEconomy")
        userDefaults.setValue(bowlerExtras, forKey: "bowlerExtras")
        userDefaults.setValue(bowlerMaidens, forKey: "bowlerMaidens")
        
        
        userDefaults.setValue(scoreBeforeOver, forKey: "scoreBeforeOver")
        
        onStrike.append(true)
        onStrike.append(false)
        userDefaults.setValue(onStrike, forKey: "onStrike")
        if(!firstInnings){
            runsTarget = userDefaults.integer(forKey: "runsTarget")
        }
        
    }
    
    //read and set dataValues
    func initialize(){
        
        firstInnings = userDefaults.bool(forKey: "firstInnings")
        runsTarget = userDefaults.integer(forKey: "runsTarget")
        HomeTeamPlayers = userDefaults.stringArray(forKey: "homePlayerNames") ?? []
        Team2Players = userDefaults.stringArray(forKey: "myKey3") ?? []

        scoreBoard.topBatsmenName = userDefaults.string(forKey: "topBatsmenName")!
        scoreBoard.bottomBatsmenName = userDefaults.string(forKey: "bottomBatsmenName")!
        scoreBoard.bowlerName = userDefaults.string(forKey: "bowlerName")!
        
        scoreBeforeOver = userDefaults.integer(forKey: "scoreBeforeOver")
        
        battingTeam = userDefaults.stringArray(forKey: "battingTeam") ?? []
        bowlingTeam = userDefaults.stringArray(forKey: "bowlingTeam") ?? []
        
        getTopBatsmenIndex()
        getBottomBatsmenIndex()
        getBowlerIndex()
        
        bat1Name.setText(scoreBoard.topBatsmenName)
        bat2Name.setText(scoreBoard.bottomBatsmenName)
        bowlerNameLabel.setText(scoreBoard.bowlerName)
        
        //save all data like batsmen/bowler runs into variables here:
        batsmenRuns = userDefaults.array(forKey: "batsmenRuns") as? [Int] ?? [Int]()
        batsmenBalls = userDefaults.array(forKey: "batsmenBalls") as? [Int] ?? [Int]()
        batsmenFours = userDefaults.array(forKey: "batsmenFours") as? [Int] ?? [Int]()
        batsmenSixes = userDefaults.array(forKey: "batsmenSixes") as? [Int] ?? [Int]()
        batsmenDots = userDefaults.array(forKey: "batsmenDots") as? [Int] ?? [Int]()
        batsmenStrikeRate = userDefaults.array(forKey: "batsmenRuns") as? [Int] ?? [Int]()
        
        bowlerRuns = userDefaults.array(forKey: "bowlerRuns") as? [Int] ?? [Int]()
        bowlerWickets = userDefaults.array(forKey: "bowlerWickets") as? [Int] ?? [Int]()
        bowlerExtras = userDefaults.array(forKey: "bowlerExtras") as? [Int] ?? [Int]()
        bowlerMaidens = userDefaults.array(forKey: "bowlerMaidens") as? [Int] ?? [Int]()
        bowlerOvers = userDefaults.array(forKey: "bowlerOvers") as? [Double] ?? [Double]()
        bowlerEconomy = userDefaults.array(forKey: "bowlerEconomy") as? [Double] ?? [Double]()
        
        totalRuns = userDefaults.integer(forKey: "totalRuns")
        totalWickets = userDefaults.integer(forKey: "totalWickets")
        totalOvers = userDefaults.double(forKey: "totalOvers")
        currentRunRate = userDefaults.double(forKey: "currentRunRate")
        hasBatted = userDefaults.array(forKey: "hasBatted") as? [Bool] ?? [Bool]()
        onStrike = userDefaults.array(forKey: "onStrike") as? [Bool] ?? [Bool]()
        
        history = userDefaults.array(forKey: "history") as? [Int] ?? [Int]()
    }
    
    func getTopBatsmenIndex(){
        scoreBoard.topbatsmenIndex = battingTeam.firstIndex(of: scoreBoard.topBatsmenName)
    }
    
    func getBottomBatsmenIndex(){
        scoreBoard.bottomBatsmenIndex = battingTeam.firstIndex(of: scoreBoard.bottomBatsmenName)
    }
    
    func getBowlerIndex(){
        scoreBoard.bowlerIndex = bowlingTeam.firstIndex(of: scoreBoard.bowlerName)
    }
    
    func showScoreBoard(){
        setInitialButtonColors()
        score.setText("\(totalRuns ?? 0)/\(totalWickets ?? 0)")
        totalOversLabel.setText("\(totalOvers ?? 0)")
        
        bat1Name.setText("\(scoreBoard.topBatsmenName ?? "" )")
        bat2Name.setText("\(scoreBoard.bottomBatsmenName ?? "" )")
        
        bowlerNameLabel.setText("\(scoreBoard.bowlerName ?? "")")
        bowlerRunsLabel.setText("\(bowlerRuns[scoreBoard.bowlerIndex])")
        bowlerOversLabel.setText("\(bowlerOvers[scoreBoard.bowlerIndex])")
        
        showScreen()
        showBatsmenOnStrike()
        displayHistory()
    }
    
    //rounds input to given decimal point
    func roundTo(num: Double, dPlace: Int) -> Double{
        return (num * (pow(10, Double(dPlace)))).rounded() / pow(10, Double(dPlace))
    }
    
    
    //responsible for the inputs 0,1,2,3,4,6
    func simpleGameInput(runs: Int){
        
        //add runs in batsmens and bowlers column
        totalRuns += runs
        batsmenRuns[getBatsmenOnStrikeIndex()] += runs
        batsmenBalls[getBatsmenOnStrikeIndex()] += 1
        bowlerRuns[scoreBoard.bowlerIndex] += runs
        
        
        //set batsmen Strike rate
        let sR = Double(batsmenRuns[getBatsmenOnStrikeIndex()])/Double(batsmenBalls[getBatsmenOnStrikeIndex()])
        let fSR = sR*100
        batsmenStrikeRate[getBatsmenOnStrikeIndex()] = Int(round(fSR))
        changeOvers()
        //increase over
        
        //sets bowler economy
        setBowlerEconomy()
        
        
        // if batsmen scored 1, 3 change strike
        if (runs%2 == 1){
            changeBatsmenOnStrike()
        }
        //display board
        checkForEnd()
        showScoreBoard()
        
    }
    
    func getBatsmenOnStrikeIndex()->Int{
        if(onStrike[0]) { return scoreBoard.topbatsmenIndex}
        else {return scoreBoard.bottomBatsmenIndex}
    }
    
    func changeBatsmenOnStrike(){
        onStrike[0] = !onStrike[0]
        onStrike[1] = !onStrike[1]
        
    }
    
    func showBatsmenOnStrike(){
        if(onStrike[0]){
            topOnStrike.setHidden(false)
            bottomOnStrike.setHidden(true)
        }
        else{
            topOnStrike.setHidden(true)
            bottomOnStrike.setHidden(false)
        }
    }
    
    func getNewBowlerName(){
        userDefaults.setValue(scoreBoard.bowlerName, forKey: "lastBowlerName")
        pushController(withName: "bowler", context: nil)
    }
    
    //saves all data into userDefaults
    func saveToUserDefaults(){
        userDefaults.setValue(scoreBoard.topBatsmenName, forKey: "topBatsmenName")
        userDefaults.setValue(scoreBoard.bottomBatsmenName, forKey: "bottomBatsmenName")
        userDefaults.setValue(scoreBoard.bowlerName, forKey: "bowlerName")
        
        userDefaults.setValue(battingTeam, forKey: "battingTeam")
        userDefaults.setValue(bowlingTeam, forKey: "bowlingTeam")
        
        userDefaults.setValue(batsmenRuns, forKey: "batsmenRuns")
        userDefaults.setValue(batsmenBalls, forKey: "batsmenBalls")
        userDefaults.setValue(batsmenFours, forKey: "batsmenFours")
        userDefaults.setValue(batsmenSixes, forKey: "batsmenSixes")
        userDefaults.setValue(batsmenDots, forKey: "batsmenDots")
        userDefaults.setValue(batsmenStrikeRate, forKey: "batsmenStrikeRate")
        
        userDefaults.setValue(bowlerRuns, forKey: "bowlerRuns")
        userDefaults.setValue(bowlerWickets, forKey: "bowlerWickets")
        userDefaults.setValue(bowlerExtras, forKey: "bowlerExtras")
        userDefaults.setValue(bowlerMaidens, forKey: "bowlerMaidens")
        userDefaults.setValue(bowlerOvers, forKey: "bowlerOvers")
        userDefaults.setValue(bowlerEconomy, forKey: "bowlerEconomy")
        
        userDefaults.setValue(totalRuns, forKey: "totalRuns")
        userDefaults.setValue(totalWickets, forKey: "totalWickets")
        userDefaults.setValue(totalOvers, forKey: "totalOvers")
        userDefaults.setValue(currentRunRate, forKey: "currentRunRate")
        userDefaults.setValue(hasBatted, forKey: "hasBatted")
        userDefaults.setValue(onStrike, forKey: "onStrike")
        userDefaults.setValue(history, forKey: "history")
        userDefaults.setValue(scoreBeforeOver, forKey: "scoreBeforeOver")
    }
    
    func changeHistory(imageType: Int){
        if(history.count>5){history.removeFirst()}
        history.append(imageType)
        
    }
    
    func displayHistory(){
        for index in 0..<history.count{
            
            switch index{
            case 0:
                imageOne.setImage(getImage(imageType: history[index]))
                imageOne.setTintColor(getImageTint(colorTintType: history[index]))
            case 1:
                imageTwo.setImage(getImage(imageType: history[index]))
                imageTwo.setTintColor(getImageTint(colorTintType: history[index]))
            case 2:
                imageThree.setImage(getImage(imageType: history[index]))
                imageThree.setTintColor(getImageTint(colorTintType: history[index]))
            case 3:
                imageFour.setImage(getImage(imageType: history[index]))
                imageFour.setTintColor(getImageTint(colorTintType: history[index]))
            case 4:
                imageFive.setImage(getImage(imageType: history[index]))
                imageFive.setTintColor(getImageTint(colorTintType: history[index]))
            case 5:
                imageSix.setImage(getImage(imageType: history[index]))
                imageSix.setTintColor(getImageTint(colorTintType: history[index]))
            default: print("never gonna happen")
            }
        }
        displaySeparators()
    }
    
        func getImage( imageType: Int) -> UIImage{
            switch imageType{
            case 0:
                return UIImage(systemName: "dot.circle.fill")!
            case 1:
                return UIImage(systemName: "1.circle.fill")!
            case 2:
                return UIImage(systemName: "2.circle.fill")!
            case 3:
                return UIImage(systemName: "3.circle.fill")!
            case 4:
                return UIImage(systemName: "4.circle.fill")!
            case 6:
                return UIImage(systemName: "6.circle.fill")!
            case 7:
                return UIImage(systemName: "e.circle.fill")!
            case 8:
                return UIImage(systemName: "w.circle.fill")!
            case 10:
                return UIImage(systemName: "circle.fill")!
            default:
                return UIImage(systemName: "circle.fill")!
            }
        }
    
    func getImageTint( colorTintType: Int) -> UIColor{
        switch colorTintType{
        case 0:
            return smallRunColor
        case 1:
            return smallRunColor
        case 2:
            return smallRunColor
        case 3:
            return threeRunColor
        case 4:
            return bigRunColor
        case 6:
            return bigRunColor
        case 7:
            return extrasColor
        case 8:
            return wicketsColor
        case 10:
            return UIColor.darkGray
        default:
            return UIColor.darkGray
        }
    }
    //displays separators
    func displaySeparators(){
        if(totalOvers > 1.0){
            let lastDigit = roundTo(num: (totalOvers.truncatingRemainder(dividingBy: 1)), dPlace: 1)
            switch lastDigit {
            case 0.1:
                separator1.setHidden(true)
                separator2.setHidden(true)
                separator3.setHidden(true)
                separator4.setHidden(true)
                separator5.setHidden(false)
            case 0.2:
                separator1.setHidden(true)
                separator2.setHidden(true)
                separator3.setHidden(true)
                separator4.setHidden(false)
                separator5.setHidden(true)
            case 0.3:
                separator1.setHidden(true)
                separator2.setHidden(true)
                separator3.setHidden(false)
                separator4.setHidden(true)
                separator5.setHidden(true)
            case 0.4:
                separator1.setHidden(true)
                separator2.setHidden(false)
                separator3.setHidden(true)
                separator4.setHidden(true)
                separator5.setHidden(true)
            case 0.5:
                separator1.setHidden(false)
                separator2.setHidden(true)
                separator3.setHidden(true)
                separator4.setHidden(true)
                separator5.setHidden(true)
            default:
                separator1.setHidden(true)
                separator2.setHidden(true)
                separator3.setHidden(true)
                separator4.setHidden(true)
                separator5.setHidden(true)
            }
        }
        else{
            separator1.setHidden(true)
            separator2.setHidden(true)
            separator3.setHidden(true)
            separator4.setHidden(true)
            separator5.setHidden(true)
        }
    }
    
    //shows Runs And Balls
    func batsmenScreen1(){
        batsmenRSR4.setText("R")
        batsmenBD6.setText("B")
        bat1Runs.setText("\(batsmenRuns[scoreBoard.topbatsmenIndex])" )
        bat2Runs.setText("\(batsmenRuns[scoreBoard.bottomBatsmenIndex])")
        bat1Balls.setText("\(batsmenBalls[scoreBoard.topbatsmenIndex])")
        bat2Balls.setText("\(batsmenBalls[scoreBoard.bottomBatsmenIndex])")
        
    }
    //Shows srikerate and dot balls
    func batsmenScreen2(){
        batsmenRSR4.setText("SR")
        batsmenBD6.setText("D")
        bat1Runs.setText("\(batsmenStrikeRate[scoreBoard.topbatsmenIndex])" )
        bat2Runs.setText("\(batsmenStrikeRate[scoreBoard.bottomBatsmenIndex])")
        bat1Balls.setText("\(batsmenDots[scoreBoard.topbatsmenIndex])")
        bat2Balls.setText("\(batsmenDots[scoreBoard.bottomBatsmenIndex])")
    }
    //shows 4's and sixes
    func batsmenScreen3(){
        batsmenRSR4.setText("4's")
        batsmenBD6.setText("6's")
        bat1Runs.setText("\(batsmenFours[scoreBoard.topbatsmenIndex])" )
        bat2Runs.setText("\(batsmenFours[scoreBoard.bottomBatsmenIndex])")
        bat1Balls.setText("\(batsmenSixes[scoreBoard.topbatsmenIndex])")
        bat2Balls.setText("\(batsmenSixes[scoreBoard.bottomBatsmenIndex])")
    }
    //shows runs and overs
    func bowlerScreen1(){
        bowlerRWE.setText("R")
        bowlerOEM.setText("O")
        bowlerRunsLabel.setText("\(bowlerRuns[scoreBoard.bowlerIndex])")
        bowlerOversLabel.setText("\(bowlerOvers[scoreBoard.bowlerIndex])")
    }
    //shows wickets and economy
    func bowlerScreen2(){
        bowlerRWE.setText("W")
        bowlerOEM.setText("Eco")
        bowlerRunsLabel.setText("\(bowlerWickets[scoreBoard.bowlerIndex])")
        bowlerOversLabel.setText("\(bowlerEconomy[scoreBoard.bowlerIndex])")
    }
    //shows extras and maidens
    func bowlerScreen3(){
        bowlerRWE.setText("E")
        bowlerOEM.setText("M")
        bowlerRunsLabel.setText("\(bowlerExtras[scoreBoard.bowlerIndex])")
        bowlerOversLabel.setText("\(bowlerMaidens[scoreBoard.bowlerIndex])")
    }
    
    @IBAction func batsmenSwipedRight(){
        //if user is on first or second screen and swipes right show next screen

        if(currentBatsmenScreen != 1){currentBatsmenScreen -= 1}
        showScreen()
    }
    
    @IBAction func batsmenSwipedLeft(){

        //if user is on second or third screen and swipes left show next screen
        if(currentBatsmenScreen != 3){currentBatsmenScreen += 1}
        showScreen()
    }
    
    @IBAction func bowlerSwipedRight(){

        // if user is on first or second screen and swipes right show next screen
        if(currentBowlerScreen != 1){currentBowlerScreen -= 1}
        showScreen()
    }
    
    @IBAction func bowlerSwipedLeft(){
 
        //if user is on second or third screen and swipes left show next screen
        if(currentBowlerScreen != 3){currentBowlerScreen += 1}
        showScreen()
    }
    
    func showScreen(){
        //show batsmen screens
        if(currentBatsmenScreen == 1){batsmenScreen1()}
        else if(currentBatsmenScreen == 2){batsmenScreen2()}
        else{batsmenScreen3()}
        
        //show bowler screens
        if(currentBowlerScreen == 1){bowlerScreen1()}
        else if(currentBowlerScreen == 2){bowlerScreen2()}
        else {bowlerScreen3()}
        
    }
    
    func checkForEnd(){
        
        //if its the first innings
        if(firstInnings){
            //if everyone has got out or overs have finished
            if(Double(oversNumberPad.overs) == totalOvers || totalWickets == battingTeam.count){
                //switch batting and bowling teams
                let tempBattingTeam = userDefaults.array(forKey: "battingTeam")
                let tempBowlingTeam = userDefaults.array(forKey: "bowlingTeam")
                userDefaults.setValue(tempBattingTeam, forKey: "bowlingTeam")
                userDefaults.setValue(tempBowlingTeam, forKey: "battingTeam")
                //save the current runs as runsTarget
                userDefaults.setValue(totalRuns, forKey: "runsTarget")
                setup()
                //record the final score
                //change state of first innings to false
                userDefaults.setValue(false, forKey: "firstInnings")
                gameHasStarted = false
                userDefaults.setValue(gameHasStarted, forKey: "gameHasStarted")
                userDefaults.removeObject(forKey: "history")
                history = userDefaults.array(forKey: "history") as? [Int] ?? [Int]()
                saveToUserDefaults()
                //presentController(withName: "changeInnings", context: nil)
                WKInterfaceController.reloadRootPageControllers(withNames: ["changeInnings"], contexts: nil, orientation: .horizontal, pageIndex: 0)
                presentController(withName: "changeInnings", context: nil)
                
            }
        }
        //if its the second innings
        else if(!firstInnings){
            if(totalRuns > runsTarget){
                
                let battingSecondTeamName = userDefaults.string(forKey: "battingSecondTeamName")
                userDefaults.setValue(battingSecondTeamName, forKey: "winningTeamName")
                WKInterfaceController.reloadRootPageControllers(withNames: ["WinningTeamScreen"], contexts: nil, orientation: .horizontal, pageIndex: 0)
                presentController(withName: "WinningTeamScreen", context: nil)
            }
            
            if(Double(oversNumberPad.overs) == totalOvers || totalWickets == battingTeam.count){
                print("inside if statement")
                let battingFirstTeamName = userDefaults.string(forKey: "battingFirstTeamName")
                userDefaults.setValue(battingFirstTeamName, forKey: "winningTeamName")
                WKInterfaceController.reloadRootPageControllers(withNames: ["WinningTeamScreen"], contexts: nil, orientation: .horizontal, pageIndex: 0)
                presentController(withName: "WinninTeamScreen", context: nil)
            }
        }
    }
    
    func changeOvers(){
        //if overs is under 5 balls
        if (Int(totalOvers*10)%10 < 5){
            totalOvers = roundTo(num: totalOvers+0.1, dPlace: 1)
            bowlerOvers[scoreBoard.bowlerIndex] = roundTo(num: bowlerOvers[scoreBoard.bowlerIndex]+0.1, dPlace: 1)
            checkForEnd()
        }
        //if the over is complete
        else{
            if(scoreBeforeOver == totalRuns){bowlerMaidens[scoreBoard.bowlerIndex] += 1}
            totalOvers = roundTo(num: totalOvers+0.5, dPlace: 1)
            bowlerOvers[scoreBoard.bowlerIndex] = roundTo(num: bowlerOvers[scoreBoard.bowlerIndex]+0.5, dPlace: 1)
            scoreBeforeOver = totalRuns
            //if over is finished change strike
            checkForEnd()
            changeBatsmenOnStrike()
            getNewBowlerName()
        }
    }
    
    func setBowlerEconomy(){
        let wholeOvers = floor(bowlerOvers[scoreBoard.bowlerIndex])
        let remainderBalls = (bowlerOvers[scoreBoard.bowlerIndex]-wholeOvers)*10
        let totalBalls = wholeOvers*6+remainderBalls
        let economy = (Double(bowlerRuns[scoreBoard.bowlerIndex]*6)/totalBalls)
        bowlerEconomy[scoreBoard.bowlerIndex] = round(10*economy)/10
    }
    
    func setInitialButtonColors(){
        dotBall.setBackgroundColor(smallRunColor)
        oneRun.setBackgroundColor(smallRunColor)
        twoRuns.setBackgroundColor(smallRunColor)
        threeRuns.setBackgroundColor(threeRunColor)
        fourRuns.setBackgroundColor(bigRunColor)
        sixRuns.setBackgroundColor(bigRunColor)
        extras.setBackgroundColor(extrasColor)
        wicket.setBackgroundColor(wicketsColor)
        other.setBackgroundColor(otherColor)
    }
}//class bracket

