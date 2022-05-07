//
//  TimeTableModel.swift
//  TimeTable
//
//  Created by Максим on 07.05.2022.
//

import RealmSwift
import Foundation

class TimeTableModel: Object {
    
    @Persisted var timeTableDate = Date()
    @Persisted var timeTableTime = Date()
    @Persisted var timeTableName: String = ""
    @Persisted var timeTableType: String = ""
    @Persisted var timeTableBuilding: String = ""
    @Persisted var timeTableAudience: String = ""
    @Persisted var timeTableTeacher: String = "Name Lastname"
    @Persisted var timeTableColor: String = "FFFFFF"
    @Persisted var timeTableRepeat: Bool = true
    @Persisted var timeTableWeekday: Int = 1
    
}
