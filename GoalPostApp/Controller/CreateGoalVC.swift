//
//  CreateGoalVC.swift
//  GoalPostApp
//
//  Created by Massimiliano Abeli on 22/08/2018.
//  Copyright © 2018 Massimiliano Abeli. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController {

    @IBOutlet weak var goalDescription: UITextView!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var goalDescriptionTxtHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextBtnHeightConstraint: NSLayoutConstraint!
    
    
    var selectedType: GoalType = .shortTerm
    // var isAnimatedUp: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardWillChange(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
    }

    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismissDetail()
    }
    
    @IBAction func shortTermBtnPressed(_ sender: Any) {
        shortTermBtn.selectedColor()
        longTermBtn.deselectedColor()
        selectedType = .shortTerm
    }
    
    @IBAction func longTermBtnPressed(_ sender: Any) {
        longTermBtn.selectedColor()
        shortTermBtn.deselectedColor()
        selectedType = .longTerm
    }
    
    @IBAction func nextBtnPressed(_ sender: Any) {
    }
    
    @objc func onKeyboardWillChange(_ notification: NSNotification) {
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt
        let curFrame = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let targetFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = targetFrame.origin.y - curFrame.origin.y
        
        UIView.animate(withDuration: duration, delay: 0.0, options: UIViewAnimationOptions(rawValue: curve), animations: {

            if UIScreen.main.bounds.height < 667 {
                self.goalDescriptionTxtHeightConstraint.constant += deltaY*0.2
            }

            self.nextBtnHeightConstraint.constant += deltaY
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
}
