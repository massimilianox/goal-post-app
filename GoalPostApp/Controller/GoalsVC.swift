//
//  GoalsVC.swift
//  GoalPostApp
//
//  Created by Massimiliano Abeli on 22/08/2018.
//  Copyright © 2018 Massimiliano Abeli. All rights reserved.
//

import UIKit
import CoreData

class GoalsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func addGoalBtnPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "createGoalVC") else { return }
        presentDetail(createGoalVC);
    }
    
}

extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? TableGoalCell {
            // cell.configureCell(description: <#T##String#>, type: <#T##String#>, progress: <#T##Int#>)
        }
        
        return UITableViewCell()
    }
}
