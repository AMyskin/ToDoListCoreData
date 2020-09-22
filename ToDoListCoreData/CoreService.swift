//
//  CoreService.swift
//  ToDoListCoreData
//
//  Created by Alexander Myskin on 22.09.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit
import CoreData


final class CoreService {
    
    private func getContext() -> NSManagedObjectContext {
         let appDelegate = UIApplication.shared.delegate as! AppDelegate
         return appDelegate.persistentContainer.viewContext
         
     }
    
    func saveTask(withTitle title: String, handler: @escaping (Task) -> Void){
        guard title != "" else {return}
        let context = getContext()
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Task", in: context) else {
            return
        }
        
        let taskObject = Task(entity: entity, insertInto: context)
        taskObject.title = title
        print(title)
        
        
        do {
            try context.save()
            //tasks.append(taskObject)
            handler(taskObject)
            
        } catch let error as NSError  {
            print(error.localizedDescription)
            
        }

    }
    
    func getTasks() -> [Task] {
        var tasks: [Task] = []
        let context = getContext()
        
        let fetchRequrest: NSFetchRequest<Task> = Task.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        
        fetchRequrest.sortDescriptors = [sortDescriptor]
        
        
        do {
            tasks = try context.fetch(fetchRequrest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
           print("tasks= \(tasks.count)")
        
        return tasks
    }
    
    func deleteTask(tasks: Task , handler: @escaping () -> Void) {
        let context = getContext()
          context.delete(tasks)
          
          do {
              try context.save()
                handler()
             
          } catch let error as NSError {
              print(error.localizedDescription)
          }
    }
    
}
