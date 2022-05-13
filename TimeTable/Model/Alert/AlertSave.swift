//
//  AlertSave.swift
//  TimeTable
//
//  Created by Максим on 10.05.2022.
//

import UIKit

extension UIViewController {
    
    func alertSave(title: String, message: String?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
}
