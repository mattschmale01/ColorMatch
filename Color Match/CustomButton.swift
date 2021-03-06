//
//  CustomButton.swift
//  Color Match
//
//  Created by Matthew Schmale on 1/15/17.
//  Copyright © 2017 Schmale Cunha. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    override func awakeFromNib() {
        layer.cornerRadius = 20.0
        layer.shadowColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.5).cgColor
        layer.shadowOpacity = 0.9
        layer.shadowRadius = 8.0
        layer.shadowOffset = CGSize(width: 0.0, height: 2.5)
        
    }

}
