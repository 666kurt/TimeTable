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
    
    func saveTimeTableModel(model: TimeTableModel) {
        try! localRealm.write {
            localRealm.add(model)
        }
    }
}
