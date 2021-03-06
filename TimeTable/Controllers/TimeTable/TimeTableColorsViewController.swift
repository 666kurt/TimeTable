//
//  TimeTableColorViewController.swift
//  TimeTable
//
//  Created by Максим on 28.04.2022.
//

import UIKit

class TimeTableColorsViewController: UITableViewController {
    
    let idOptionColorCell = "idOptionColorCell"
    let idOptionTimeTableHeader = "idOptionTimeTableHeader"
    
    let headerNameArray = ["RED", "ORANGE", "YELLOW", "GREEN", "BLUE", "DEEP BLUE", "PURPLE"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.9686, alpha: 1.0)
        tableView.register(ColorsTableViewCell.self, forCellReuseIdentifier: idOptionColorCell)
        tableView.register(HeaderOptionsViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionTimeTableHeader)
        
        title = "Colors TimeTable"
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionColorCell, for: indexPath) as! ColorsTableViewCell
        cell.cellConfigure(indexPath: indexPath)
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
        switch indexPath.section {
        case 0: setColor(color: "BE2813")
        case 1: setColor(color: "F07F5A")
        case 2: setColor(color: "F3AF22")
        case 3: setColor(color: "467C24")
        case 4: setColor(color: "2D7FC1")
        case 5: setColor(color: "1A4766")
        case 6: setColor(color: "2D038F")
        default:
            setColor(color: "FFFFFF")
        }
    }
    
    private func setColor(color: String) {
        let timeTableOptions = self.navigationController?.viewControllers[1] as? TimeTableOptionsViewController
        timeTableOptions?.hexColorCell = color
        timeTableOptions?.tableView.reloadRows(at: [[3, 0], [4, 0]], with: .none)
        self.navigationController?.popViewController(animated: true)
    }
    
}

