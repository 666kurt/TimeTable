//
//  OptionsTimeTableViewCell.swift
//  TimeTable
//
//  Created by Максим on 22.04.2022.
//

import UIKit

class OptionsTableViewCell: UITableViewCell {
    
    let backgroundViewCell: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameCellLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let repeatSwitch: UISwitch = {
        let repeatSwitch = UISwitch()
        repeatSwitch.isOn = true
        repeatSwitch.isHidden = true
        repeatSwitch.onTintColor = .cyan
        repeatSwitch.translatesAutoresizingMaskIntoConstraints = false
        return repeatSwitch
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
            setConstraints()
        
            self.selectionStyle = .none
            self.backgroundColor = .clear
            
        repeatSwitch.addTarget(self, action: #selector(switchChange(paramTarger:)), for: .valueChanged)
            
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellTimeTableConfigure(nameArray: [[String]], indexPath: IndexPath) {
        nameCellLabel.text = nameArray[indexPath.section][indexPath.row]
        
        if indexPath == [3, 0] {
            backgroundViewCell.backgroundColor = .cyan
        }
        
        if indexPath == [4, 0] {
            repeatSwitch.isHidden = false
        }
    }
    
    func cellTasksConfigure(nameArray: [String], indexPath: IndexPath) {
        nameCellLabel.text = nameArray[indexPath.section]
        
        if indexPath == [3, 0] {
            backgroundViewCell.backgroundColor = .cyan
        }
    }
    
    func cellContactsConfigure(nameArray: [String], indexPath: IndexPath) {
        nameCellLabel.text = nameArray[indexPath.section]
        
        indexPath.section == 4 ? backgroundViewCell.image = UIImage(systemName: "person.fill.badge.plus") : nil
        
    }
    
    @objc func switchChange(paramTarger: UISwitch) {
        if paramTarger.isOn {
            print("on")
        } else {
            print("off")
        }
    }
    
    func setConstraints() {
        
        self.addSubview(backgroundViewCell)
        NSLayoutConstraint.activate([
            backgroundViewCell.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            backgroundViewCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            backgroundViewCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            backgroundViewCell.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1)
        ])
        
        self.addSubview(nameCellLabel)
        NSLayoutConstraint.activate([
            nameCellLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameCellLabel.leadingAnchor.constraint(equalTo: backgroundViewCell.leadingAnchor, constant: 15),
        ])
        
        self.contentView.addSubview(repeatSwitch)
        NSLayoutConstraint.activate([
            repeatSwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            repeatSwitch.trailingAnchor.constraint(equalTo: backgroundViewCell.trailingAnchor, constant: -15)
        ])

    }
        
}

