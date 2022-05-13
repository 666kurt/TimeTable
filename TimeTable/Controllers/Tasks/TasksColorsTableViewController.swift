//
//  ColorTaskTableViewController.swift
//  TimeTable
//
//  Created by Максим on 29.04.2022.
//

import UIKit

class TasksColorsTableViewController: UITableViewController {
    
    let idTaskColorCell = "idTaskColorCell"
    let idTaskTimeTableHeader = "idTaskTimeTableHeader"
    
    let headerNameArray = ["RED", "ORANGE", "YELLOW", "GREEN", "BLUE", "DEEP BLUE", "PURPLE"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.9686, alpha: 1.0)
        tableView.register(ColorsTableViewCell.self, forCellReuseIdentifier: idTaskColorCell)
        tableView.register(HeaderOptionsViewCell.self, forHeaderFooterViewReuseIdentifier: idTaskTimeTableHeader)
        
        title = "Colors Tasks"
        
    }
    
    private func setColor(color: String) {
        let timeTableOptions = self.navigationController?.viewControllers[1] as? TasksOptionsTableView
        timeTableOptions?.hexColorCell = color
        timeTableOptions?.tableView.reloadRows(at: [[3, 0]], with: .none)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idTaskColorCell, for: indexPath) as! ColorsTableViewCell
        cell.cellConfigure(indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idTaskTimeTableHeader) as! HeaderOptionsViewCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tap")
    }
}


