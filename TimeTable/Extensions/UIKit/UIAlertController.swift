//
//  UIAlertController.swift
//  TimeTable
//
//  Created by Максим on 28.04.2022.
//

import UIKit

extension UIAlertController {
    
    func negativeWidthConstraint() {
        
        for subView in self.view.subviews {
            for constraints in subView.constraints where constraints.debugDescription.contains("width == -16") {
                subView.removeConstraint(constraints)
            }
        }
    }    
}

