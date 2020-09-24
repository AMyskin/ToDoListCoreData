//
//  RealmTask.swift
//  ToDoListCoreData
//
//  Created by Alexander Myskin on 22.09.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import Foundation
import RealmSwift

class RealmTask: Object {
    @objc dynamic var title: String = ""
}
