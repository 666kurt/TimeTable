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
    @Persisted var timeTableName: String = "Unknown"
    @Persisted var timeTableType: String = "Unknown"
    @Persisted var timeTableBuilding: String = "Unknown"
    @Persisted var timeTableAudience: String = "Unknown"
    @Persisted var timeTableTeacher: String = "Unknown"
    @Persisted var timeTableColor: String = "1A4766"
    @Persisted var timeTableRepeat: Bool = true
    @Persisted var timeTableWeekday: Int = 1
    
}
