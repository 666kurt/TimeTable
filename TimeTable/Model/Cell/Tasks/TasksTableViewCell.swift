//
//  TasksTableViewCell.swift
//  TimeTable
//
//  Created by Максим on 20.04.2022.
//

import UIKit

class TasksTableViewCell: UITableViewCell{
    
    let taskName = UILabel(text: "Программирование", font: .avenirNextDemiBold20())
    let taskDescription = UILabel(text: "Научиться что-то делать", font: .avenirNext14())
    
    let readyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.setBackgroundImage(UIImage(systemName: "chevron.down.circle"), for: .normal)
        return button
    }()
    
    weak var cellTaskDelegate: PressReadyTaskButtonProtocol?
    var index: IndexPath?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
            setConstraints()
        
            taskDescription.numberOfLines = 2
            self.selectionStyle = .none
        
            readyButton.addTarget(self, action: #selector(readyButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func readyButtonTapped() {
        guard let index = index else {
            return
        }
        cellTaskDelegate?.readyButtonTapped(indexPath: index)
    }
    
    func setConstraints() {
        
        self.contentView.addSubview(readyButton)
        NSLayoutConstraint.activate([
            readyButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            readyButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            readyButton.heightAnchor.constraint(equalToConstant: 30),
            readyButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        self.addSubview(taskName)
        NSLayoutConstraint.activate([
            taskName.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            taskName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            taskName.trailingAnchor.constraint(equalTo: readyButton.leadingAnchor, constant: -5),
            taskName.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        self.addSubview(taskDescription)
        NSLayoutConstraint.activate([
            taskDescription.topAnchor.constraint(equalTo: taskName.topAnchor, constant: 15),
            taskDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            taskDescription.trailingAnchor.constraint(equalTo: readyButton.leadingAnchor, constant: -5),
            taskDescription.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])

   }
}

