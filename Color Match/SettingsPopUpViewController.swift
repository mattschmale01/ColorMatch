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
            MOVETIME = 0.7
        } else if difficultyBar.selectedSegmentIndex == 1 {
            MOVETIME = 1.0
        } else if difficultyBar.selectedSegmentIndex == 0 {
            MOVETIME = 1.3
        }
    }
    
    // Func: Sets sound and vibration preferences
    func setSoundPreferences() {
        if !soundSwitch.isOn {
            IS_BUZZER_ON = false
            IS_SOUND_ON = false
        }
        if !vibrationsSwitch.isOn {
            IS_VIBRATE_ON = false
        }
    }
}
