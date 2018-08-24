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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData { (success) in
            print("success")
            tableView.reloadData()
            if goals.count > 0 {
                tableView.isHidden = false
            } else {
                tableView.isHidden = true
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
            cell.configureCell(forGoal: goal)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (rowAction, indexPath) in
            self.removeGoal(forIndexPath: indexPath)
            self.fetchData(completion: { (success) in
                if success {
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                    if self.goals.count > 0 {
                        self.tableView.isHidden = false
                    } else {
                        self.tableView.isHidden = true
                    }
                } else {
                    print("something went terribly wrong")
                }
            })
        }
        
        delete.backgroundColor = #colorLiteral(red: 0.9009682801, green: 0.1568627506, blue: 0.2162470031, alpha: 1)
        
        let progress = UITableViewRowAction(style: .normal, title: "Add") { (rowAction, indexPath) in
            self.setProgress(forGoalAtIndexPath: indexPath)
            self.fetchData(completion: { (success) in
                if success {
                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
                }
            })
        }
        
        
        return [delete, progress]
    }
}

extension GoalsVC {
    
    func setProgress(forGoalAtIndexPath indexPath: IndexPath) {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let manageContext = delegate.persistentContainer.viewContext
        
        guard let goal = goals[indexPath.row] as? Goal else { return }
        if goal.goalProgress < goal.goalValue {
            goal.goalProgress += 1
        } else {
            return
        }
        
        do {
            try manageContext.save()
        } catch {
            debugPrint(error.localizedDescription)
        }
        
    }
    
    func removeGoal(forIndexPath indexPath: IndexPath) {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let manageContext = delegate.persistentContainer.viewContext
        
        manageContext.delete(goals[indexPath.row] as! Goal)
        
        do {
            try manageContext.save()
        } catch {
            debugPrint(error.localizedDescription)
        }
        
    }
    
    func fetchData(completion: (_ success: Bool) -> ()) {
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let manageContext = delegate.persistentContainer.viewContext

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
