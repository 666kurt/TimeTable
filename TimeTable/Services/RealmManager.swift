//
//  RealmManager.swift
//  TimeTable
//
//  Created by Максим on 07.05.2022.
//

import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    
    private init() {}
    
    let localRealm = try! Realm()
    
    // TimeTable model
    
    func saveTimeTableModel(model: TimeTableModel) {
        try! localRealm.write {
            localRealm.add(model)
        }
    }
    
    func deleteTimeTableModel(model: TimeTableModel) {
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
    
    // Tasks model
    
    func saveTasksModel(model: TaskModel) {
        try! localRealm.write {
            localRealm.add(model)
        }
    }
    
    func deleteTasksModel(model: TaskModel) {
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
    
    func updateReadyButtonTasksModel(task: TaskModel, bool: Bool) {
        try! localRealm.write {
            task.tasksReady = bool
        }
    }
    
    // Contacts model
    
    func saveContactModel(model: ContactModel) {
        try! localRealm.write {
            localRealm.add(model)
        }
    }
    
    func deleteContactModel(model: ContactModel) {
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
}
