//
//  ContactModel.swift
//  TimeTable
//
//  Created by Максим on 13.05.2022.
//

import RealmSwift
import Foundation

class ContactModel: Object {
    
    @Persisted var contactsName = "Unknown"
    @Persisted var contactsPhone = "Unknown"
    @Persisted var contactsMail = "Unknown"
    @Persisted var contactsType = "Unknown"
    @Persisted var contactsImage: Data?
    
}
