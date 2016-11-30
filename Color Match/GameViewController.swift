//
//  GameViewController.swift
//  Color Match
//
//  Created by Matthew Schmale on 11/30/16.
//  Copyright © 2016 Schmale Cunha. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    var isAlive = true
    var timer: Timer!
    var rngNum = arc4random(7)
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        while(isAlive){
           colorLabel.text =
        }
        

    }
    
    // Color maps
    var colorNameMap = ["blue", "red", "green"]
    var colorHexMap = ["#0080ff", "#ff0000", "#00ff00"]
    
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
        
     
    }
    @IBAction func yesBtn(_ sender: Any) {
        if isAlive {
            
        }
        
    }
    
    @IBOutlet weak var colorLabel: UILabel!
    
    
    
    
    
    
func startTimer(){
        if timer != nil{
            timer.invalidate()
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: Selector(" "), userInfo: nil, repeats: true)
    }

    
}
