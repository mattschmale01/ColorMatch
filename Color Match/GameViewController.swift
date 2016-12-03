//
//  GameViewController.swift
//  Color Match
//
//  Created by Matthew Schmale on 11/30/16.
//  Copyright © 2016 Schmale Cunha. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    // Connect labels
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var highScoreLbl: UILabel!
    
    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var noBtn: UIButton!
    
    // Declaring game variables
    let MOVETIME = 3
    var score = 0
    var isAlive = true
    var timer: Timer!
    var currTime: Int?
    var curText: String = ""
    var curColor: String = ""
    
    // Color maps
    let colorNameMap = ["blue", "red", "green"]
    let colorHexMap = ["#0080ff", "#ff0000", "#00ff00"]

    // Onload function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiUpdates()
        
        highScoreLbl.text = String(score)
        currTime = MOVETIME
        startTimer()
        newPlay()
    }
    
    //Func: Loads UI Updates
    func uiUpdates(){
        yesBtn.layer.cornerRadius = 5.0
        noBtn.layer.cornerRadius = 5.0
        
        
        yesBtn.alpha = 0.5
        noBtn.alpha = 0.5
    }
    
    // Func: adds points to high score label
    func addPoints() {
        score += 1
        highScoreLbl.text = String(score)
        currTime = MOVETIME
    }
    
    // Func: ends game
    func gameOver() {
        highScoreLbl.text = "Game over! Score: " + String(score)
        highScoreLbl.textColor = UIColor.red
        isAlive = false
        
        if score > ViewController.highScore {
            ViewController.highScore = score
        }
        score = 0
    }
    
    // Func: generates new text and color
    func newPlay() {
        curText = colorNameMap[randInt(range: 3)]
        colorLabel.text = curText
        
        curColor = colorHexMap[randInt(range: 3)]
        colorLabel.textColor = hexStringToUIColor(hex: curColor)
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
    
    @IBAction func noBtn(_ sender: Any) {
        if isAlive {
            if colorNameMap.index(of: curText) != colorHexMap.index(of: curColor) {
                addPoints()
                newPlay()
            } else {
                gameOver()
            }
        }
    }
    @IBAction func yesBtn(_ sender: Any) {
        if isAlive {
            if colorNameMap.index(of: curText) == colorHexMap.index(of: curColor) {
                addPoints()
                newPlay()
            } else {
                gameOver()
            }
        }
    }
    
    func countDown() {
        currTime! -= 1
        if currTime! <= 0 {
            gameOver()
        }
    }
    
    // func: start the timer thingy
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(GameViewController.countDown), userInfo: nil, repeats: true)
    }
}
