//
//  OptionTimeTableViewController.swift
//  TimeTable
//
//  Created by Максим on 22.04.2022.
//

import UIKit

class TimeTableOptionsViewController: UITableViewController {
    
    let idOptionTimeTableCell = "idOptionTimeTableCell"
    let idOptionTimeTableHeader = "idOptionTimeTableHeader"
    
    let headerNameArray = ["DATE AND TIME", "LESSON", "TEACHER", "COLOR", "PERIOD"]

    let cellNameArray = [["Date", "Time"],
                         ["Name", "Type", "Building", "Audience"],
                         ["Teacher name"],
                         [""],
                         ["Repeate every 7 days"]]
    
    let timeTableModel = TimeTableModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.9686, alpha: 1.0)
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: idOptionTimeTableCell)
        tableView.register(HeaderOptionsViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionTimeTableHeader)
        
        title = "Options TimeTable"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
    }
    
    @objc func saveButtonTapped() {
        RealmManager.shared.saveTimeTableModel(model: timeTableModel)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 2
        case 1: return 4
        case 2: return 1
        case 3: return 1
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionTimeTableCell, for: indexPath) as! OptionsTableViewCell
        cell.cellTimeTableConfigure(nameArray: cellNameArray, indexPath: indexPath)
        cell.switchRepeatDelegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionTimeTableHeader) as! HeaderOptionsViewCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
        
        switch indexPath {
        case [0, 0]:
            alertDate(label: cell.nameCellLabel) { (numberWeekday, date) in
                self.timeTableModel.timeTableDate = date
                self.timeTableModel.timeTableWeekday = numberWeekday
        }
        case [0, 1]:
            alertTime(label: cell.nameCellLabel) { (time) in
                self.timeTableModel.timeTableTime = time
        }
        case [1, 0]:
            alertForCellName(label: cell.nameCellLabel, name: "Name lesson", placeholder: "Enter name lesson") { text in
                self.timeTableModel.timeTableName = text
        }
        case [1, 1]:
            alertForCellName(label: cell.nameCellLabel, name: "Type lesson", placeholder: "Enter type lesson") { text in
                self.timeTableModel.timeTableType = text
        }
        case [1, 2]:
            alertForCellName(label: cell.nameCellLabel, name: "Number of building", placeholder: "Enter number of building") { text in
                self.timeTableModel.timeTableBuilding = text
        }
        case [1, 3]:
            alertForCellName(label: cell.nameCellLabel, name: "Number of audience", placeholder: "Enter number of audience") { text in
                self.timeTableModel.timeTableAudience = text
        }
        case [2, 0]: pushControllers(vc: TeachersViewController())
        case [3, 0]: pushControllers(vc: TimeTableColorsViewController())
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

extension TimeTableOptionsViewController: SwitchRepeatProtocol {
    func switchRepeat(value: Bool) {
        timeTableModel.timeTableRepeat = value
    }
}
