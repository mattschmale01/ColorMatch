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
        
      
            if let scoreData = UserDefaults.standard.integer(forKey: "SCORE") as Int?{
                highScoreLbl.text = "High Score: \(scoreData)"
            } else {
                highScoreLbl.text = "Play to Begin!"
            }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }


}

