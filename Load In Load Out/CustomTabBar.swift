//
//  CustomTabBar.swift
//  Load In Load Out
//
//  Created by Caleb Lindsey on 10/17/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class CustomTabBar : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.barTintColor = GlobalVariables.yellowForTintColor
        self.tabBar.unselectedItemTintColor = UIColor.darkGray
        self.tabBar.tintColor = UIColor.black
        self.tabBar.itemSpacing = 100
        
        //Setup view controllers
        let truckController = TruckController()
        let truckNavController = UINavigationController(rootViewController: truckController)
        truckNavController.tabBarItem.title = "Trucks"
        truckNavController.tabBarItem.image = UIImage(named: "truck")
        
        let equipmentController = EquipmentController()
        let equipmentNavController = UINavigationController(rootViewController: equipmentController)
        equipmentNavController.tabBarItem.title = "Equipment"
        equipmentNavController.tabBarItem.image = UIImage(named: "equipment")
        
        let incidentController = IncidentReportController()
        let incidentNavController = UINavigationController(rootViewController: incidentController)
        incidentNavController.tabBarItem.title = "Incident Report"
        incidentNavController.tabBarItem.image = UIImage(named: "incident")
        
        //Array of viewcontrollers
        viewControllers = [truckNavController, equipmentNavController, incidentNavController]
        
    }
    
}
