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

    override func viewDidLoad() {
        super.viewDidLoad()
            if let scoreData = UserDefaults.standard.integer(forKey: "SCORE") as Int?{
                    ViewController.highScore = scoreData
                    highScoreLbl.text = "Your High Score: \(Int(ViewController.highScore!))"
            } else {
                    ViewController.highScore = 0
                    highScoreLbl.text = "Press Play!"
            }
    }
}

