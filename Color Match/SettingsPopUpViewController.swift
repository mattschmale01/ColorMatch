//
//  SettingsPopUpViewController.swift
//  Color Match
//
//  Created by Peter Cunha on 1/15/17.
//  Copyright © 2017 Schmale Cunha. All rights reserved.
//

import UIKit
import Foundation

class SettingsPopUpViewController: UIViewController {
    
    //IBOutlets
    @IBOutlet weak var vibrationsSwitch: UISwitch!
    @IBOutlet weak var soundSwitch: UISwitch!
    @IBOutlet weak var difficultyBar: UISegmentedControl!
    
    // Close pop-up
    @IBAction func closePopUp(_ sender: Any) {
        self.removeAnimate()
    }
    
    // Action Func: Close popup when user click out of bounds
    @IBAction func touchedOutOfBounds(_ sender: Any) {
        self.removeAnimate()
    }
    
    // Func: Actions for pop-up load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.showAnimate()
        
        // Change UI elements to selected settings
        
        // Sound switch
        if !(USER_PREFERENCES.object(forKey:"IS_SOUND_ON") as! Bool?)! {
            soundSwitch.setOn(false, animated: false)
        }
        // Vibration Switch
        if !(USER_PREFERENCES.object(forKey:"IS_VIBRATE_ON") as! Bool?)! {
            vibrationsSwitch.setOn(false, animated: false)
        }
        // Difficulty control
        let difficulty:Double = (USER_PREFERENCES.object(forKey:"MOVETIME") as! Double?)!
        if difficulty == 0.7 {
            difficultyBar.selectedSegmentIndex = 2
        } else if difficulty == 1.0 {
            difficultyBar.selectedSegmentIndex = 1
        } else if difficulty == 1.3 {
            difficultyBar.selectedSegmentIndex = 0
        }
    }

    // Func: Animate pop-up into screen
    func showAnimate() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    // Func: Remove pop-up and preform closing actions
    func removeAnimate() {
        
        // Animations
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
            
        // Closing functions
        }, completion: {
            (finished : Bool)  in
            if (finished) {
                // Set user preferences
                self.setMoveTime()
                self.setSoundPreferences()
                
                // Close settings pop-up
                self.view.removeFromSuperview()
            }
        })
    }
    
    // Func: Sets move time preference
    func setMoveTime() {
        if difficultyBar.selectedSegmentIndex == 2 {
            USER_PREFERENCES.set(0.7, forKey: "MOVETIME")
        } else if difficultyBar.selectedSegmentIndex == 1 {
            USER_PREFERENCES.set(1.0, forKey: "MOVETIME")
        } else if difficultyBar.selectedSegmentIndex == 0 {
            USER_PREFERENCES.set(1.3, forKey: "MOVETIME")
        }
    }
    
    // Func: Sets sound and vibration preferences
    func setSoundPreferences() {
        if !soundSwitch.isOn {
            USER_PREFERENCES.set(false, forKey: "IS_SOUND_ON")   // Sound
            USER_PREFERENCES.set(false, forKey: "IS_BUZZER_ON")  // Buzzer
        }
        if !vibrationsSwitch.isOn {
            USER_PREFERENCES.set(false, forKey: "IS_VIBRATE_ON") // Vibration
        }
    }
}
