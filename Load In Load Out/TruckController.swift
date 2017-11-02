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
    
    let truckTitleLable : UILabel = {
        let label = UILabel()
        label.textColor = GlobalVariables.yellowColor
        label.font = UIFont(name: "Helvetica", size: 35)
        return label
    }()
    
    let dateLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont(name: "Helvetica", size: 25)
        label.text = "11 • 26 • 17"
        return label
    }()
    
    let crateTableView : UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    
    let truckNotesView : UITextView = {
        let textView = UITextView()
        textView.textColor = UIColor.white
        textView.backgroundColor = UIColor.clear
        textView.font = UIFont(name: "Helvetica", size: 11)
        textView.isEditable = false
        textView.layer.borderColor = UIColor.white.cgColor
        textView.layer.borderWidth = 0.3
        return textView
    }()
    
    let captainLabel : UILabel = {
        let label = UILabel()
        label.textColor = GlobalVariables.yellowColor
        label.font = UIFont(name: "Helvetica", size: 20)
        label.text = "Truck Captain: "
        return label
    }()
    
    let loadStatus : UISwitch = {
        let switcher = UISwitch()
        return switcher
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
            truckTableView.register(TruckCell.self, forCellReuseIdentifier: "truckCell")
            view.addSubview(truckTableView)
            
            // Place title label
            truckTitleLable.frame = CGRect(x: truckTableView.frame.maxX + 25, y: statusBarHeight + navHeight! + 25, width: window.frame.width - truckTableView.frame.width - 25 - 25, height: 50)
            view.addSubview(truckTitleLable)
            
            // Place date label
            dateLabel.frame = CGRect(x: truckTitleLable.frame.origin.x, y: truckTitleLable.frame.maxY, width: truckTitleLable.frame.width / 2, height: 50)
            view.addSubview(dateLabel)
            
            // Place truck notes view
            truckNotesView.frame = CGRect(x: truckTitleLable.frame.origin.x, y: dateLabel.frame.maxY, width: view.frame.width - truckTableView.frame.width - 25 - 25, height: 200)
            view.addSubview(truckNotesView)
            
            // Place captian label
            captainLabel.frame = CGRect(x: truckNotesView.frame.origin.x, y: truckNotesView.frame.maxY + 5, width: truckNotesView.frame.width, height: 50)
            view.addSubview(captainLabel)
            
            // Place crate table view
            crateTableView.frame = CGRect(x: 0, y: 0, width: 0, height: 500)
            crateTableView.delegate = self
            crateTableView.dataSource = self
            crateTableView.register(UITableViewCell.self, forCellReuseIdentifier: "crateCell")
            view.addSubview(crateTableView)
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == truckTableView {
            let cell : TruckCell = truckTableView.dequeueReusableCell(withIdentifier: "truckCell", for: indexPath) as! TruckCell
            cell.truckTitleLabel.text = GlobalVariables.arrayOfTrucks[indexPath.row].title
            cell.truckImage.image = UIImage(named: "truck")
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
            
            truckTitleLable.text = GlobalVariables.arrayOfTrucks[indexPath.row].title
            truckNotesView.text = GlobalVariables.arrayOfTrucks[indexPath.row].notes
            captainLabel.text = "Truck Captain: \(GlobalVariables.arrayOfTrucks[indexPath.row].captain)"
            
        }
    }
    
}
































