//
//  ContactOptionTableViewController.swift
//  TimeTable
//
//  Created by Максим on 06.05.2022.
//

import UIKit

class ContactsOptionsTableViewController: UITableViewController {
    
    let idOptionContactCell = "idOptionContactCell"
    let idOptionContactHeader = "idOptionContactHeader"
    
    let headerNameArray = ["NAME", "PHONE", "MAIL", "TYPE", "CHOSE IMAGE"]
    let cellNameArray = ["Name", "Phone", "Mail", "Type", ""]
    
    var contactModel = ContactModel()
    var imageIsChange = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Options Contact"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.9686, alpha: 1.0)
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: idOptionContactCell)
        tableView.register(HeaderOptionsViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionContactHeader)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        
    }
    
    @objc private func saveButtonTapped() {
        
        if contactModel.contactsName == "Unknown" || contactModel.contactsType == "Unknown" {
            alertSave(title: "Error", message: "Requered fileds: NAME, TYPE")
        } else {
            setImageModel()
            RealmManager.shared.saveContactModel(model: contactModel)
            contactModel = ContactModel()
            alertSave(title: "Success", message: nil)
            tableView.reloadData()
        }
    }
    
    func pushControllers(vc: UIViewController) {
        let viewController = vc
        navigationController?.pushViewController(viewController, animated: true)
        navigationController?.navigationBar.topItem?.title = "Options"
    }
    
    @objc func setImageModel() {
        
        if imageIsChange {
            let cell = tableView.cellForRow(at: [4, 0]) as! OptionsTableViewCell
            let image = cell.backgroundViewCell.image
            guard let imageData = image?.pngData() else { return }
            contactModel.contactsImage = imageData
            cell.backgroundViewCell.contentMode = .scaleAspectFit
            imageIsChange = false
        } else {
            contactModel.contactsImage = nil
        }
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionContactCell, for: indexPath) as! OptionsTableViewCell
        cell.cellContactsConfigure(nameArray: cellNameArray, indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.section == 4 ? 200 : 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionContactHeader) as! HeaderOptionsViewCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
        
       switch indexPath.section {
       case 0: alertForCellName(label: cell.nameCellLabel, name: "Name Contact", placeholder: "Enter name contact") { text in
           self.contactModel.contactsName = text
       }
       case 1: alertForCellName(label: cell.nameCellLabel, name: "Phone Contact", placeholder: "Enter phone contact") { text in
           self.contactModel.contactsPhone = text
       }
       case 2: alertForCellName(label: cell.nameCellLabel, name: "Mail Contact", placeholder: "Enter main contact") { text in
           self.contactModel.contactsMail = text
       }
       case 3: alertFriendOrTeacher(label: cell.nameCellLabel) { (type) in
           self.contactModel.contactsType = type
       }
       case 4: alertPhotoOrCamera { [self] source in
           chooseImagePicker(sourse: source)
       }
       default:
           print("Tap ContactTableView")
        }
    }
}

extension ContactsOptionsTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImagePicker(sourse: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(sourse) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = sourse
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let cell = tableView.cellForRow(at: [4, 0]) as! OptionsTableViewCell
        cell.backgroundViewCell.image = info[.editedImage] as? UIImage
        cell.backgroundViewCell.contentMode = .scaleAspectFill
        cell.backgroundViewCell.clipsToBounds = true
        imageIsChange = true
        dismiss(animated: true)
    }
}
