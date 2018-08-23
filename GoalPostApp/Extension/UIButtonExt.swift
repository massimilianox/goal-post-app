//
//  UIButtonExt.swift
//  GoalPostApp
//
//  Created by Massimiliano Abeli on 23/08/2018.
//  Copyright © 2018 Massimiliano Abeli. All rights reserved.
//

import UIKit

extension UIButton {
    
    func selectedColor() {
        self.backgroundColor = #colorLiteral(red: 0.4973257184, green: 0.7762238383, blue: 0.8543422818, alpha: 1)
    }
    
    func deselectedColor() {
        self.backgroundColor = #colorLiteral(red: 0.4980392157, green: 0.7762238383, blue: 0.8543422818, alpha: 0.6)
    }
    
} 
