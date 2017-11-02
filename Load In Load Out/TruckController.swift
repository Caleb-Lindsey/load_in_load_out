//
//  TruckController.swift
//  Load In Load Out
//
//  Created by Caleb Lindsey on 10/17/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class TruckController : CustomViewController, UITableViewDelegate, UITableViewDataSource {
    
    let truckTableView : UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    
    let QRcodeView : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let crateTableView : UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBarHeight = statusBar.frame.height
        let navHeight = self.navigationController?.navigationBar.frame.height
        
        truckTableView.selectRow(at: IndexPath(row: 0, section: 0) , animated: true, scrollPosition: .none)
        truckTableView.cellForRow(at: IndexPath(row: 0, section: 0))?.isSelected = true
        
        if let window = UIApplication.shared.keyWindow {
            
            // Place table view
            truckTableView.frame = CGRect(x: 0, y: statusBarHeight + navHeight!, width: window.frame.width * (4/10), height: window.frame.height - statusBarHeight - navHeight!)
            truckTableView.delegate = self
            truckTableView.dataSource = self
            truckTableView.register(UITableViewCell.self, forCellReuseIdentifier: "truckCell")
            view.addSubview(truckTableView)
            
            // Place QRcode View
            QRcodeView.frame = CGRect(x: truckTableView.frame.maxX + 100, y: statusBarHeight + navHeight! + 50, width: window.frame.width - truckTableView.frame.width - 200, height: window.frame.width - truckTableView.frame.width - 200)
            QRcodeView.image = UIImage(named: "QRCode")
            view.addSubview(QRcodeView)
            
            // Place crate table view
            crateTableView.frame = CGRect(x: QRcodeView.frame.origin.x - 50, y: QRcodeView.frame.maxY + 25, width: QRcodeView.frame.width + 100, height: 500)
            crateTableView.delegate = self
            crateTableView.dataSource = self
            crateTableView.register(UITableViewCell.self, forCellReuseIdentifier: "crateCell")
            view.addSubview(crateTableView)
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == truckTableView {
            let cell = truckTableView.dequeueReusableCell(withIdentifier: "truckCell", for: indexPath)
            cell.textLabel?.text = GlobalVariables.arrayOfTrucks[indexPath.row].title
            cell.textLabel?.textAlignment = .center
            return cell
        } else {
            let cell = crateTableView.dequeueReusableCell(withIdentifier: "crateCell", for: indexPath)
            cell.textLabel?.text = GlobalVariables.arrayOfTrucks[(truckTableView.indexPathForSelectedRow?.row)!].crates[indexPath.row].title
            cell.textLabel?.textAlignment = .center
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == truckTableView {
            return GlobalVariables.arrayOfTrucks.count
        } else {
            return GlobalVariables.arrayOfTrucks[(truckTableView.indexPathForSelectedRow?.row)!].crates.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == truckTableView {
            return 100

        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == truckTableView {
            crateTableView.reloadData()
        }
    }
    
}
































