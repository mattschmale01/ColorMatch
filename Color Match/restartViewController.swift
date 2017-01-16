//
//  restartViewController.swift
//  Color Match
//
//  Created by Matthew Schmale on 1/15/17.
//  Copyright © 2017 Schmale Cunha. All rights reserved.
//

import UIKit


class restartViewController: UIViewController {
    var timer: Timer!
    
    @IBOutlet weak var closeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        showAnimate()
        closeBtn.isEnabled = false
        setUpTimer()
        
    }

    //Func: When the close button is pressed

    @IBAction func onBtnPress(_ sender: Any) {
        removeAnimate()
    }
    
    //Func: Runs animation
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    //Func: Runs closing animation
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
                
                
            }
        });
    }
    
    //Func: Sets up timer
    func setUpTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(restartViewController.enableCloseBtn), userInfo: nil, repeats: false)
    }
    
    //Func: Enables close button
    func enableCloseBtn(){
        timer.invalidate()
        closeBtn.isEnabled = true
    }
}
