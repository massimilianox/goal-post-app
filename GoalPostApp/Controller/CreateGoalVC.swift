//
//  CreateGoalVC.swift
//  GoalPostApp
//
//  Created by Massimiliano Abeli on 22/08/2018.
//  Copyright © 2018 Massimiliano Abeli. All rights reserved.
//

import UIKit
import CoreData


class CreateGoalVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var goalDescription: UITextView!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var goalPointsTxtField: UITextField!
    
    // Constraint for animations
    @IBOutlet weak var goalDescriptionTxtHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextBtnHeightConstraint: NSLayoutConstraint!
    
    
    var selectedType: GoalType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalDescription.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardWillChange(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if goalDescription.text == "What is your goal?" {
            goalDescription.text = ""
            goalDescription.textColor = #colorLiteral(red: 0.4973257184, green: 0.7762238383, blue: 0.8543422818, alpha: 1)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if goalDescription.text == "" {
            goalDescription.text = "What is your goal?"
            goalDescription.textColor = UIColor.lightGray
        }
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
        if goalDescription.text != "What is your goal?" &&
            goalPointsTxtField.text != "" &&
            selectedType != nil {
            self.saveGoalData { (success) in
                if success {
                    print("Successfully saved data")
                    dismissDetail()
                } else {
                    print("Something went terribly wrong")
                }
            }
        }
    }
    
    @objc func onKeyboardWillChange(_ notification: NSNotification) {
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt
        let curFrame = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let targetFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = targetFrame.origin.y - curFrame.origin.y
        
        UIView.animate(withDuration: duration, delay: 0.0, options: UIViewAnimationOptions(rawValue: curve), animations: {
            if UIScreen.main.bounds.height < 667 {
                self.goalDescriptionTxtHeightConstraint.constant += deltaY*0.3
            }

            self.nextBtnHeightConstraint.constant += deltaY
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func saveGoalData(completion: (_ success: Bool) -> ()) {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let manageContext = delegate.persistentContainer.viewContext
        let goal = Goal(context: manageContext)
        goal.goalDescription = goalDescription.text
        goal.goalProgress = Int32(0)
        goal.goalType = selectedType?.rawValue
        goal.goalValue = Int32(goalPointsTxtField.text!)!
        
        do {
            try manageContext.save()
            completion(true)
        } catch {
            debugPrint(error.localizedDescription)
            completion(false)
        }
        
    }
    
}
