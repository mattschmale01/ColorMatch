//
//  helpViewPopUpController.swift
//  Color Match
//
//  Created by Matthew Schmale on 1/15/17.
//  Copyright © 2017 Schmale Cunha. All rights reserved.
//

import UIKit

class helpViewPopUpController: UIViewController {
    
    //Func: Closes Help Screen
    
    @IBAction func onCloseBtnPress(_ sender: Any) {
        removeAnimate()
  
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        showAnimate()
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
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
}
