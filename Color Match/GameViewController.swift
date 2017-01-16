//
//  GameViewController.swift
//  Color Match
//
//  Created by Matthew Schmale on 11/30/16.
//  Copyright © 2016 Schmale Cunha. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox


class GameViewController: UIViewController {
    
    //Audio Variables
    var player: AVAudioPlayer?
    
    
    // Connected labels
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var highScoreLbl: UILabel!
    @IBOutlet weak var timeLeftLbl: UILabel!
    @IBOutlet weak var backGndImg: UIImageView!
    
    //Connected Buttons
    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var noBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var resetBtn: CustomButton!
    
    // Declaring game variables
    let MOVETIME = 1.0
    var score = 0
    var isAlive = true
    var timer: Timer!
    var currTime: Double?
    var curText: String = ""
    var curColor: String = ""
    var deathCount = 0
    
    // Color maps
    let colorNameMap = ["Blue", "Red", "Green", "Orange", "Yellow", "Pink", "Purple"]
    let colorHexMap = ["#0080ff", "#ff0000", "#00ff00", "#ffa500", "#ffff00", "#ff1493", "#9400d3"]

    // Onload function
    override func viewDidLoad() {
        super.viewDidLoad()
        uiUpdates()
        loadGame()
    }
    

    // Func: actions for onload
    func loadGame(){
        score = 0
        highScoreLbl.text = String(score)
        highScoreLbl.textColor = UIColor.black
        currTime = MOVETIME
        startTimer()
        newPlay()
        isAlive = true
    }
    
    //Func: Check death
    func checkDeath(){
        if deathCount % 11 == 0 && deathCount != 0 {
            deathCount += 1
            playSound(fileName: "ben")
        } else if deathCount % 7 == 0 && deathCount != 0 {
            deathCount += 1
            playSound(fileName: "horn")
        } else {
            deathCount += 1
            playSound(fileName: "fail")
        }
    }
    
    //Func: Plays a sound of our choice
    func playSound(fileName: String) {
        guard let sound = NSDataAsset(name: fileName) else {
            print("Asset not found")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(data: sound.data, fileTypeHint: AVFileTypeWAVE)
            
            player!.play()
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
        }
    }
    
    //Func: Updates Data
    func updateNSUserDefaults(score: Int){
        UserDefaults.standard.set(score, forKey:"SCORE")
    }
    
    //Func: Checks to update HighScore
    func checkHighScore(CurrentScore: Int){
        if (CurrentScore > ViewController.highScore!) {
            ViewController.highScore = CurrentScore
            updateNSUserDefaults(score: CurrentScore)
        }
    }
    
    //Func: Loads UI Updates
    func uiUpdates(){
        backBtn.setTitleColor(UIColor.black, for: .normal)
        resetBtn.isEnabled = false
    }
    
    // Func: adds points to high score label
    func addPoints() {
        score += 1
        highScoreLbl.text = String(score)
        currTime = MOVETIME
    }
    
    // Func: Ends game
    func gameOver() {
        checkDeath()
        
        // Play sound and vibrate phone
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        // Update highscore info
        highScoreLbl.text = "Game over! Score: " + String(score)
        highScoreLbl.textColor = UIColor.red
        checkHighScore(CurrentScore: score)
        
        // Housekeeping
        backBtn.setTitleColor(UIColor.red, for: .normal)
        isAlive = false
        
        resetBtn.isEnabled = true
        restartPopUp()
        
    }
    
    // Func: generates new text and color
    func newPlay() {
        
        if (randInt(range: 2) == 0) {
            // Generate random label and color
            
            // Sub-Func: Make sure that the color and text are different
            var r1 = 0
            var r2 = 0
            func generateDifferentValues() {
                r1 = randInt(range: colorNameMap.count)
                r2 = randInt(range: colorNameMap.count)
                
                if (r1 == r2) {
                    generateDifferentValues()
                }
            }
            generateDifferentValues()
            
            // Assign color and label
            curText = colorNameMap[r1]
            colorLabel.text = curText
            
            curColor = colorHexMap[r2]
            colorLabel.textColor = hexStringToUIColor(hex: curColor)
            
        } else {
            // Generate matching label and color
            
            let setRange = randInt(range: colorNameMap.count);
            
            // Assign color and label
            curText = colorNameMap[setRange]
            colorLabel.text = curText
            
            curColor = colorHexMap[setRange]
            colorLabel.textColor = hexStringToUIColor(hex: curColor)
            
        }
    }
    
    // Func: generates a random number
    func randInt(range:Int) -> Int {
        return Int(arc4random_uniform(UInt32(range)))
    }
    
    // Func: converts hexes to UIColor object
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    //Func: "No" button clicked
    @IBAction func noBtn(_ sender: Any) {
        if isAlive {
            if colorNameMap.index(of: curText) != colorHexMap.index(of: curColor) {
                playSound(fileName: "tap")
                addPoints()
                newPlay()
            } else {
                timer.invalidate()
                timeLeftLbl.text = ""
                gameOver()
            }
        } else {
           // loadGame()
        }
    }
    
    //Func: "Yes" button clicked
    @IBAction func yesBtn(_ sender: Any) {
        if isAlive {
            if colorNameMap.index(of: curText) == colorHexMap.index(of: curColor) {
                playSound(fileName: "tap")
                addPoints()
                newPlay()
            } else {
                timer.invalidate()
                gameOver()
                timeLeftLbl.text = ""
            }
        } else {
           // loadGame()
        }
    }
    
    //Func: Count down timer
    func countDown() {
        currTime! -= 0.1
        timeLeftLbl.text = String(Double(round(10*currTime!)/10))
        if currTime! <= 0 {
            timeLeftLbl.text = "Time's up!"
            timer.invalidate()
            gameOver()
        }
    }
    
    //Func: Start the timer
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(GameViewController.countDown), userInfo: nil, repeats: true)
    }
    
    //Func: Send restart pop-up
    func restartPopUp(){
        let popUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "restartPopUpID") as! restartViewController
        self.addChildViewController(popUpVC)
        popUpVC.view.frame = self.view.frame
        self.view.addSubview(popUpVC.view)
        popUpVC.didMove(toParentViewController: self)
    }
    
    @IBAction func onResetBtnPress(_ sender: Any) {
        loadGame()
        resetBtn.isEnabled = false
    }
    
    
    
    
}
