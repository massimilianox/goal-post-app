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
    
    var goals: [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        // NotificationCenter.default.addObserver(self, selector: #selector(goalsDataDidUpdate), name: Notification.Name("goalsDataDidUpdate"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData { (success) in
            print("success")
            tableView.reloadData()
            if goals.count > 0 {
                // print(goals as Any)
                tableView.isHidden = false
            }
        }
    }

    @IBAction func addGoalBtnPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "createGoalVC") else { return }
        presentDetail(createGoalVC);
    }
    
}

extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? TableGoalCell {
            
            guard let goal = goals[indexPath.row] as? Goal else { return UITableViewCell() }
            print(goal)
            cell.configureCell(
                description: goal.goalDescription!,
                type: goal.goalType!,
                progress: goal.goalProgress
            )
            
            return cell
        }
        
        return UITableViewCell()
    }
}

extension GoalsVC {
    func fetchData(completion: (_ success: Bool) -> ()) {
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let manageContext = delegate.persistentContainer.viewContext

        // guard let manageContext = sharedDelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        
        do {
            goals = try manageContext.fetch(fetchRequest)
            completion(true)
        } catch {
            debugPrint(error.localizedDescription)
            completion(false)
        }
        
    }
}
