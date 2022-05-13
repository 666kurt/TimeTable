//
//  TasksModel.swift
//  TimeTable
//
//  Created by Максим on 12.05.2022.
//

import RealmSwift
import Foundation

class TaskModel: Object {
    
    @Persisted var taskDate: Date?
    @Persisted var tasksName: String = "Unknown"
    @Persisted var tasksDescription: String = "Unknown"
    @Persisted var tasksColor: String = "1A4766"
    @Persisted var tasksReady: Bool = true
    
}
