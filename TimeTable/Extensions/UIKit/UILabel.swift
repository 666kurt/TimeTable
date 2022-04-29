//
//  UILabel.swift
//  TimeTable
//
//  Created by Максим on 20.04.2022.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont?, alignment: NSTextAlignment = .left) {
        self.init()
        
        self.text = text
        self.textColor = .black
        self.textAlignment = alignment
        self.font = font
        self.adjustsFontSizeToFitWidth = true
        self.translatesAutoresizingMaskIntoConstraints = false
        
    }
}


