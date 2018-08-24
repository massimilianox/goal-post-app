//
//  TableGoalCell.swift
//  GoalPostApp
//
//  Created by Massimiliano Abeli on 22/08/2018.
//  Copyright © 2018 Massimiliano Abeli. All rights reserved.
//

import UIKit

class TableGoalCell: UITableViewCell {

    @IBOutlet weak var goalLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var goalProgressLbl: UILabel!
    @IBOutlet weak var completeGoalView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(forGoal goal: Goal) {
        
        goalLbl.text = goal.goalDescription
        typeLbl.text = goal.goalType
        goalProgressLbl.text = String(describing: goal.goalProgress)
        
        if goal.goalProgress < goal.goalValue {
            completeGoalView.isHidden = true
        } else {
            completeGoalView.isHidden = false
        }
        
    }

}
