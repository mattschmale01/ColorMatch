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
    
    // Close popUp
    @IBAction func closePopUp(_ sender: Any) {
        self.removeAnimate()
    }
    
    // Action Func: Close popup when user click out of bounds
    @IBAction func touchedOutOfBounds(_ sender: Any) {
        self.removeAnimate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.showAnimate()
    }

    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion: {
            (finished : Bool)  in
            if (finished) {
                self.getMoveTime()
                self.view.removeFromSuperview()
            }
        })
    }
    func getMoveTime(){
        if difficultyBar.selectedSegmentIndex == 2 {
            MOVETIME = 0.7
        } else if difficultyBar.selectedSegmentIndex == 1 {
            MOVETIME = 1.0
        } else if difficultyBar.selectedSegmentIndex == 0 {
            MOVETIME = 1.3
        }
        
    }
}
