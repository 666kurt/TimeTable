//
//  TaskOptionTableView.swift
//  TimeTable
//
//  Created by Максим on 29.04.2022.
//

import UIKit

class TasksOptionsTableView: UITableViewController {
    
    let idOptionTasksCell = "idOptionTasksCell"
    let idOptionTasksHeader = "idOptionTasksHeader"
    
    let headerNameArray = ["DATE", "LESSON", "TASK", "COLOR"]
    
    let cellNameArray = ["Date", "Lesson", "Task", ""]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.9686, alpha: 1.0)
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: idOptionTasksCell)
        tableView.register(HeaderOptionsViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionTasksHeader)
        
        title = "Options Task"
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionTasksCell, for: indexPath) as! OptionsTableViewCell
        cell.cellTasksConfigure(nameArray: cellNameArray, indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionTasksHeader) as! HeaderOptionsViewCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
        
        switch indexPath.section {
        case 0: alertDate(label: cell.nameCellLabel) { (numberWeekday, date) in
            print(numberWeekday, date)
        }
        case 1: alertForCellName(label: cell.nameCellLabel, name: "Name lesson", placeholder: "Enter name lesson") { text in
            print(text)
        }
        case 2: alertForCellName(label: cell.nameCellLabel, name: "Name task", placeholder: "Enter name task") { text in
            print(text)
        }
        case 3: pushControllers(vc: TasksColorsTableViewController())
        default:
            print("error")
        }
    }
    
    func pushControllers(vc: UIViewController) {
        let viewController = vc
        navigationController?.pushViewController(viewController, animated: true)
        navigationController?.navigationBar.topItem?.title = "Options"
    }
    
}

