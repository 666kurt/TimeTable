//
//  TimeTableViewCell.swift
//  TimeTable
//
//  Created by Максим on 19.04.2022.
//

import UIKit

class TimeTableViewCell: UITableViewCell{
    
    let lessonName = UILabel(text: "", font: .avenirNextDemiBold20())
    let teacherName = UILabel(text: "", font: .avenirNext20(), alignment: .right)
    let lessonTime = UILabel(text: "", font: .avenirNextDemiBold20())
    let typeLabel = UILabel(text: "Тип:", font: .avenirNext14(), alignment: .right)
    let lessonType = UILabel(text: "", font: .avenirNextDemiBold14())
    let buildingLabel = UILabel(text: "Корпус", font: .avenirNext14(), alignment: .right)
    let lessonBuilding = UILabel(text: "", font: .avenirNextDemiBold14())
    let audLabel = UILabel(text: "Аудитория:", font: .avenirNext14(), alignment: .right)
    let lessonAud = UILabel(text: "", font: .avenirNextDemiBold14())

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
            setConstraints()
            self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: TimeTableModel) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        lessonName.text = model.timeTableName
        teacherName.text = model.timeTableTeacher
        lessonTime.text = dateFormatter.string(from: model.timeTableTime)
        lessonType.text = model.timeTableType
        lessonBuilding.text = model.timeTableBuilding
        lessonAud.text = model.timeTableAudience
        backgroundColor = UIColor().colorFromHex("\(model.timeTableColor)")
        
    }
    
    func setConstraints() {
        
        let topStackView = UIStackView(arrangedSubviews: [lessonName, teacherName], axis: .horizontal, spacing: 10, distribution: .fillEqually)

        self.addSubview(topStackView)
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            topStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            topStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5),
            topStackView.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        self.addSubview(lessonTime)
        NSLayoutConstraint.activate([
            lessonTime.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            lessonTime.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            lessonTime.widthAnchor.constraint(equalToConstant: 100),
            lessonTime.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        let bottomStackView = UIStackView(arrangedSubviews: [typeLabel, lessonType, buildingLabel, lessonBuilding, audLabel, lessonAud], axis: .horizontal, spacing: 10, distribution: .fillProportionally)
        
        self.addSubview(bottomStackView)
        NSLayoutConstraint.activate([
            bottomStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            bottomStackView.leadingAnchor.constraint(equalTo: lessonTime.trailingAnchor, constant: 5),
            bottomStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            bottomStackView.heightAnchor.constraint(equalToConstant: 25)
        ])
   }
}
