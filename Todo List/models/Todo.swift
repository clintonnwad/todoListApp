//
//  Todo.swift
//  Todo List
//
//  Created by Jovi on 24/11/2022.
//
//  GROUP NUMBER: 15
//  NAMES:
//  Clinton Nwadiukor  - 301291242
//  Jovi Chen-Mcintyre - 301125059
//
//  DESCRIPTION:
//  Simple ToDo application that performs basic Todo functions
//  Users can create a task, modify and update existing tasks
//  The app is available in portrait and landscape
//
//  REVISION HISTORY:
//  https://github.com/clintonnwad/todoListApp
//
//  DATE LAST MODIFIED:
//  November 27, 2022

import Foundation
import RealmSwift

class TodoTask: Object {
   @Persisted(primaryKey: true) var _id: ObjectId
   @Persisted var name: String = ""
   @Persisted var isCompleted: Bool
   @Persisted var hasDueDate: Bool
   @Persisted var dueDate: Date?
   @Persisted var note: String
   convenience init(name: String) {
       self.init()
       self.name = name
   }
    
   //function use to save this or self obj to realm database
   func create(){
       let realm = try! Realm()
       try! realm.write {
           realm.add(self)
       }
    }
    
    //function update obj in realm database
    func update(){
        let realm = try! Realm()
        try! realm.write {
            realm.add(self, update: .modified)
        }
    }
    
    //function use to delete obj from realm database
    func delete(){
        let realm = try! Realm()
        try! realm.write {
            realm.delete(self)
        }
    }
    
    //static function use to access data for list for todoTasks from realm database
    static func getAllTodos()->Results<TodoTask>{
        let realm = try! Realm()
        return realm.objects(TodoTask.self)
    }
}
