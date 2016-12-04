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
    static var highScore = 0

    @IBAction func onBtnPress(_ sender: Any) {
   
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (UserDefaults.standard.value(forKey: "highScore") as? Int) != nil{
            highScoreLbl.text = "Your high score is " + String(ViewController.highScore)
        } else {
                highScoreLbl.text = "Hit the play button to begin!"
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

