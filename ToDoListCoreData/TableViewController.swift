//
//  TableViewController.swift
//  ToDoListCoreData
//
//  Created by Alexander Myskin on 22.09.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var tasks: [Task] = []
    let coreService = CoreService()
    
    @IBAction func saveTask(_ sender: UIBarButtonItem) {
        showAlert{ (taksText) in
            self.coreService.saveTask(withTitle: taksText){(task) in
                self.tasks.append(task)
                self.tableView.reloadData()
            }
        }
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tasks = coreService.getTasks()
        
    }
    

    // MARK: - Table view data source
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.title
        
        return cell
    }
    
    

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            
            coreService.deleteTask(tasks: tasks[indexPath.row]){ [weak self] in
                
                self?.tasks.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            
            
            
        } else if editingStyle == .insert {
            print ("insert \(indexPath.row)")
        }
    }
 
    
    // MARK:  -  showAlert
    
    
    private func showAlert(handler: @escaping (_ taksText: String) -> Void){
        let alertController = UIAlertController(title: "New Task", message: "Task", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default){ action in
            let tf = alertController.textFields?.first
            if let newTaskTitle = tf?.text {
                handler(newTaskTitle)
            }
        }
        
        
        alertController.addTextField { _ in
            let textTf = alertController.textFields?.first
            textTf?.placeholder = "Enter New Task"
            textTf?.clearButtonMode = .always
            if let newTaskTitle = textTf?.text {
                self.coreService.saveTask(withTitle: newTaskTitle){(task) in
                    self.tasks.append(task)
                    self.tableView.reloadData()
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in }
        
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
}
