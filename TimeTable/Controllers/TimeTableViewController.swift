//
//  TimeTableViewController.swift
//  TimeTable
//
//  Created by Максим on 18.04.2022.
//

import UIKit
import FSCalendar

class TimeTableViewController: UIViewController {
    
    var calendarHeightConstraint : NSLayoutConstraint!
    
    private var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "TimeTable"
        
        setConstraints()
        
    }
}

// MARK: SetConstraints

extension TimeTableViewController {
    
    func setConstraints() {
        view.addSubview(calendar)
        
        calendarHeightConstraint = NSLayoutConstraint(item: calendar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        calendar.addConstraint(calendarHeightConstraint)
        
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }
    
}
