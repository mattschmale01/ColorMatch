//
//  CustomView.swift
//  Color Match
//
//  Created by Matthew Schmale on 1/15/17.
//  Copyright © 2017 Schmale Cunha. All rights reserved.
//

import UIKit

class CustomView: UIView {

    override func awakeFromNib() {
        layer.cornerRadius = 5.0
        layer.shadowColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.5).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        
    }


}
