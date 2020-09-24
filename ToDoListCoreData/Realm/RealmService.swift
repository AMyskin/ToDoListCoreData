//
//  RealmService.swift
//  ToDoListCoreData
//
//  Created by Alexander Myskin on 22.09.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import UIKit
import RealmSwift

final class RealmService {
    
    lazy var realm: Realm = {
        var config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        config.schemaVersion = 0
        let realm = try! Realm(configuration: config)
        //print(realm.configuration.fileURL ?? "")
        return realm
    }()
    
    func saveTaskToRealm(_ tasks: RealmTask) {
        do{
            //let realm = try Realm()
            //let oldObjects = realm.objects(RealmTask.self)
            try realm.write{
                //realm.delete(oldObjects)
                realm.add(tasks)
            }
        }catch{
            print(error)
        }
    }
    lazy var taskFromReal: Results<RealmTask> = {
        return realm.objects(RealmTask.self)
    }()
    
    func deleteTaskToRealm(_ tasks: RealmTask, handler: @escaping () -> Void) {
                do{
                    
                    try realm.write{
                        realm.delete(tasks)
                        handler()
                 }
             }catch{
                 print(error)
             }
    }

    
}
