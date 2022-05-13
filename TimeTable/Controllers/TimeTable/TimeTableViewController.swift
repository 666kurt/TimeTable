//
//  TimeTableViewController.swift
//  TimeTable
//
//  Created by Максим on 18.04.2022.
//

import UIKit
import FSCalendar
import RealmSwift

class TimeTableViewController: UIViewController {
    
    let idTimeCell = "idTimeCell"
    var calendarHeightConstraint : NSLayoutConstraint!
    
    var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    
    let showHideButton : UIButton = {
        let button = UIButton()
        button.setTitle("Open calendar", for: .normal)
        button.setTitleColor(UIColor.systemGray, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let tableView : UITableView = {
        let tableView = UITableView()
        tableView.bounces = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let localRealm = try! Realm()
    var timeTableArray: Results<TimeTableModel>!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "TimeTable"
            
        calendar.delegate = self
        calendar.dataSource = self
        calendar.scope = .week
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TimeTableViewCell.self, forCellReuseIdentifier: idTimeCell)
        
        setConstraints()
        swipeAction()
        timeTableOnDay(date: Date())
        
        showHideButton.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        
        navigationController?.tabBarController?.tabBar.scrollEdgeAppearance = navigationController?.tabBarController?.tabBar.standardAppearance
    }
    
    @objc func addButtonTapped() {
        
        let timetableOption = TimeTableOptionsViewController()
        navigationController?.pushViewController(timetableOption, animated: true)
        
    }
    
    @objc func showHideButtonTapped() {
        
        if calendar.scope == .week {
            calendar.setScope(.month, animated: true)
            showHideButton.setTitle("Close calendar", for: .normal)
        } else {
            calendar.setScope(.week, animated: true)
            showHideButton.setTitle("Open calendar", for: .normal)
        }
        
    }
    
// MARK: SwipeGestureRecognizer
    
    func swipeAction() {
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeUp.direction = .up
        calendar.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeDown.direction = .down
        calendar.addGestureRecognizer(swipeDown)
        
    }
    
    
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
        
        switch gesture.direction {
        case .up:
            showHideButtonTapped()
        case .down:
            showHideButtonTapped()
        default:
            break
        }
    }
    
    private func timeTableOnDay(date: Date) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: date)
        guard let weekday = components.weekday else { return }
        
        let dateStart = date
        let dateEnd: Date = {
            let components = DateComponents(day: 1, second: -1)
            return Calendar.current.date(byAdding: components, to: dateStart)!
        }()
        
        let predicateRepeat = NSPredicate(format: "timeTableWeekday = \(weekday) AND timeTableRepeat = true")
        let predicateUnrepeat = NSPredicate(format: "timeTableRepeat = true AND timeTableDate BETWEEN %@", [dateStart, dateEnd])
        let compound = NSCompoundPredicate(type: .or, subpredicates: [predicateRepeat, predicateUnrepeat])
        
        timeTableArray = localRealm.objects(TimeTableModel.self).filter(compound).sorted(byKeyPath: "timeTableTime")
        
        tableView.reloadData()
    }
    
}

// MARK: UITableViewDelegate, UITableViewDataSourse

extension TimeTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeTableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idTimeCell, for: indexPath) as! TimeTableViewCell
        let model = timeTableArray[indexPath.row]
        cell.configure(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let editingRow = timeTableArray[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            RealmManager.shared.deleteTimeTableModel(model: editingRow)
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}

// MARK: FSCalendarDataSource, FSCalendarDelegate

extension TimeTableViewController: FSCalendarDataSource, FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeightConstraint.constant = bounds.height
        view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        timeTableOnDay(date: date)
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
        
        view.addSubview(showHideButton)        
        NSLayoutConstraint.activate([
            showHideButton.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 0),
            showHideButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            showHideButton.heightAnchor.constraint(equalToConstant: 20),
            showHideButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: showHideButton.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
