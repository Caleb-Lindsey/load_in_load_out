//
//  CustomViewController.swift
//  Load In Load Out
//
//  Created by Caleb Lindsey on 10/17/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class CustomViewController : UIViewController {
    
    let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = GlobalVariables.grayColor
        
        statusBar.tintColor = UIColor.clear
        
    }
    
}
