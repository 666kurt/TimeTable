//
//  ViewController.swift
//  TimeTable
//
//  Created by Максим on 18.04.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        
    }
    
    func setupTabBar() {
        
        let timetableViewController = createNavController(vc: TimeTableViewController(), itemName: "TimeTable", itemImage: "calendar.badge.clock")
        let tasksViewController = createNavController(vc: TasksViewController(), itemName: "Tasks", itemImage: "text.badge.checkmark")
        let contactsViewController = createNavController(vc: ContactsViewController(), itemName: "Contacts", itemImage: "rectangle.stack.person.crop")
        
        viewControllers = [timetableViewController, tasksViewController, contactsViewController]
        
    }
    
    
    func createNavController(vc: UIViewController, itemName: String, itemImage: String) -> UINavigationController {
        
        let item = UITabBarItem(title: itemName, image: UIImage(systemName: itemImage)?.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)), tag: 0)
        item.titlePositionAdjustment = .init(horizontal: 0, vertical: 10)
        
        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem = item
        
        return navController
    }
}

