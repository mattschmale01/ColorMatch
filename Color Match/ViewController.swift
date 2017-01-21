//
//  ViewController.swift
//  Color Match
//
//  Created by Matthew Schmale on 11/30/16.
//  Copyright © 2016 Schmale Cunha. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    @IBOutlet weak var highScoreLbl: UILabel!
    static var highScore: Int?

    @IBAction func onBtnPress(_ sender: Any) {
   
    }
    
    // Show settings pop up
    @IBAction func showSettingsPopUp(_ sender: Any) {
        let popUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "settingsPopUpID") as! SettingsPopUpViewController
        self.addChildViewController(popUpVC)
        popUpVC.view.frame = self.view.frame
        self.view.addSubview(popUpVC.view)
        popUpVC.didMove(toParentViewController: self)
    }
    
    //Func: Shows help screen
    @IBAction func showHelpPopUp(_ sender: Any) {
        let popUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "helpPopUpID") as! helpViewPopUpController
        self.addChildViewController(popUpVC)
        popUpVC.view.frame = self.view.frame
        self.view.addSubview(popUpVC.view)
        popUpVC.didMove(toParentViewController: self)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load NSUserDefault user preferences for the first and only time
        if (USER_PREFERENCES.object(forKey: "MOVETIME") == nil) {
            USER_PREFERENCES.set(1.3,  forKey: "MOVETIME")      // Movetime
            USER_PREFERENCES.set(true, forKey: "IS_VIBRATE_ON") // Vibration
            USER_PREFERENCES.set(true, forKey: "IS_BUZZER_ON")  // Buzzer Noise
            USER_PREFERENCES.set(true, forKey: "IS_SOUND_ON")   // Sounds
        }
        
        if let scoreData = UserDefaults.standard.integer(forKey: "SCORE") as Int?{
                ViewController.highScore = scoreData
                highScoreLbl.text = "High Score: \(Int(ViewController.highScore!))"
        } else {
                ViewController.highScore = 0
                highScoreLbl.text = "Press Play!"
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent //or default
    }
}

