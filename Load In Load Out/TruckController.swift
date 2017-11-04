//
//  TruckController.swift
//  Load In Load Out
//
//  Created by Caleb Lindsey on 10/17/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class TruckController : CustomViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Variables
    
    let loadTruckButton : UIButton = {
        let button = UIButton()
        button.setTitle("Load Truck", for: .normal)
        button.backgroundColor = GlobalVariables.grayColor
        button.showsTouchWhenHighlighted = true
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(loadTruck), for: .touchUpInside)
        return button
    }()
    
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
    
    let itemTableView : UITableView = {
        let tableview = UITableView()
        tableview.allowsSelection = false
        return tableview
    }()
    
    let truckNotesView : UITextView = {
        let textView = UITextView()
        textView.textColor = UIColor.white
        textView.backgroundColor = UIColor.clear
        textView.font = UIFont(name: "Helvetica", size: 15)
        textView.isEditable = false
        textView.layer.borderColor = UIColor.white.cgColor
        textView.layer.borderWidth = 0.3
        return textView
    }()
    
    let editTruckButton : UIButton = {
        let button = UIButton()
        button.setTitle("Edit Truck", for: .normal)
        button.backgroundColor = GlobalVariables.grayColor
        button.showsTouchWhenHighlighted = true
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    let duplicateTruckButton : UIButton = {
        let button = UIButton()
        button.setTitle("Duplicate Truck", for: .normal)
        button.backgroundColor = GlobalVariables.grayColor
        button.showsTouchWhenHighlighted = true
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    let captainLabel : UILabel = {
        let label = UILabel()
        label.textColor = GlobalVariables.yellowColor
        label.font = UIFont(name: "Helvetica", size: 20)
        label.text = "Captain: "
        return label
    }()
    
    let loadStatus : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.red
        label.font = UIFont(name: "Helvetica", size: 20)
        label.text = "Not Loaded"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBarHeight = statusBar.frame.height
        let navHeight = self.navigationController?.navigationBar.frame.height
        
        truckTableView.selectRow(at: IndexPath(row: 0, section: 0) , animated: true, scrollPosition: .none)
        truckTableView.cellForRow(at: IndexPath(row: 0, section: 0))?.isSelected = true
        
        if let window = UIApplication.shared.keyWindow {
            
            // Place load truck button
            loadTruckButton.frame = CGRect(x: 0, y: statusBarHeight + navHeight!, width: window.frame.width * (4/10), height: 50)
            view.addSubview(loadTruckButton)
            
            // Place truck table view
            truckTableView.frame = CGRect(x: 0, y: loadTruckButton.frame.maxY, width: loadTruckButton.frame.width, height: window.frame.height - statusBarHeight - navHeight! - loadTruckButton.frame.height)
            truckTableView.delegate = self
            truckTableView.dataSource = self
            truckTableView.register(TruckCell.self, forCellReuseIdentifier: "truckCell")
            view.addSubview(truckTableView)
            
            // Place title label
            truckTitleLable.frame = CGRect(x: truckTableView.frame.maxX + 25, y: statusBarHeight + navHeight! + 25, width: window.frame.width - truckTableView.frame.width - 25 - 25, height: 30)
            view.addSubview(truckTitleLable)
            
            // Place date label
            dateLabel.frame = CGRect(x: truckTitleLable.frame.origin.x, y: truckTitleLable.frame.maxY, width: truckTitleLable.frame.width / 2, height: 30)
            view.addSubview(dateLabel)
            
            // Place crate table view
            crateTableView.frame = CGRect(x: truckTitleLable.frame.origin.x, y: dateLabel.frame.maxY + 15, width: truckTitleLable.frame.width / 2 - 7.5, height: 450)
            crateTableView.delegate = self
            crateTableView.dataSource = self
            crateTableView.register(UITableViewCell.self, forCellReuseIdentifier: "crateCell")
            view.addSubview(crateTableView)
            
            // Place item table view
            itemTableView.frame = CGRect(x: crateTableView.frame.maxX + 15, y: crateTableView.frame.origin.y, width: crateTableView.frame.width, height: crateTableView.frame.height)
            itemTableView.delegate = self
            itemTableView.dataSource = self
            itemTableView.register(UITableViewCell.self, forCellReuseIdentifier: "itemCell")
            view.addSubview(itemTableView)
            
            // Place truck notes view
            truckNotesView.frame = CGRect(x: crateTableView.frame.origin.x, y: crateTableView.frame.maxY + 15, width: view.frame.width - truckTableView.frame.width - 25 - 25, height: 200)
            view.addSubview(truckNotesView)
            
            // Place edit truck button
            editTruckButton.frame = CGRect(x: truckNotesView.frame.origin.x, y: truckNotesView.frame.maxY + 15, width: truckNotesView.frame.width / 2 - 7.5, height: 50)
            view.addSubview(editTruckButton)
            
            // Place duplicate truck button
            duplicateTruckButton.frame = CGRect(x: editTruckButton.frame.maxX + 15, y: editTruckButton.frame.origin.y, width: editTruckButton.frame.width, height: 50)
            view.addSubview(duplicateTruckButton)
            
            // Place captian label
            captainLabel.frame = CGRect(x: editTruckButton.frame.origin.x, y: editTruckButton.frame.maxY + 5, width: truckNotesView.frame.width, height: 20)
            view.addSubview(captainLabel)
            
            // Place load status
            loadStatus.frame = CGRect(x: captainLabel.frame.origin.x, y: captainLabel.frame.maxY, width: captainLabel.frame.width, height: captainLabel.frame.height)
            view.addSubview(loadStatus)
            
            setupView()
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == truckTableView {
            let cell : TruckCell = truckTableView.dequeueReusableCell(withIdentifier: "truckCell", for: indexPath) as! TruckCell
            cell.truckTitleLabel.text = GlobalVariables.arrayOfTrucks[indexPath.row].title
            cell.truckImage.image = UIImage(named: "truck")
            return cell
        } else if tableView == crateTableView{
            let cell = crateTableView.dequeueReusableCell(withIdentifier: "crateCell", for: indexPath)
            cell.textLabel?.text = GlobalVariables.arrayOfTrucks[(truckTableView.indexPathForSelectedRow?.row)!].crates[indexPath.row].title
            cell.textLabel?.textAlignment = .left
            return cell
        } else {
            let cell = itemTableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
            cell.textLabel?.text = GlobalVariables.arrayOfTrucks[(truckTableView.indexPathForSelectedRow?.row)!].crates[(crateTableView.indexPathForSelectedRow?.row)!].items[indexPath.row].title
            cell.textLabel?.textAlignment = .center
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == truckTableView {
            return GlobalVariables.arrayOfTrucks.count
        } else if tableView == crateTableView {
            return GlobalVariables.arrayOfTrucks[(truckTableView.indexPathForSelectedRow?.row)!].crates.count
        } else {
            return GlobalVariables.arrayOfTrucks[(truckTableView.indexPathForSelectedRow?.row)!].crates[(crateTableView.indexPathForSelectedRow?.row)!].items.count
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
            captainLabel.text = "Captain: \(GlobalVariables.arrayOfTrucks[indexPath.row].captain)"
            
            if GlobalVariables.arrayOfTrucks[indexPath.row].loaded {
                loadStatus.text = "Loaded"
                loadStatus.textColor = UIColor.green
                loadTruckButton.setTitle("Unload Truck", for: .normal)
            } else {
                loadStatus.text = "Not Loaded"
                loadStatus.textColor = UIColor.red
                loadTruckButton.setTitle("Load Truck", for: .normal)
            }
            
        } else if tableView == crateTableView {
            
            itemTableView.reloadData()
            
        } else {
            
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == truckTableView {
            return "Trucks"
        } else if tableView == crateTableView {
            return "Crates"
        } else {
            return "Items in this Crate"
        }
    }
    
    func setupView() {
        if GlobalVariables.arrayOfTrucks.count != 0 {
            truckTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .none)
            crateTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .none)
            truckTitleLable.text = GlobalVariables.arrayOfTrucks[0].title
            truckNotesView.text = GlobalVariables.arrayOfTrucks[0].notes
            captainLabel.text = "Captain: \(GlobalVariables.arrayOfTrucks[0].captain)"
            
            if GlobalVariables.arrayOfTrucks[0].loaded {
                loadStatus.text = "Loaded"
                loadStatus.textColor = UIColor.green
                loadTruckButton.setTitle("Unload Truck", for: .normal)
            } else {
                loadStatus.text = "Not Loaded"
                loadStatus.textColor = UIColor.red
                loadTruckButton.setTitle("Load Truck", for: .normal)
            }
            
        }
    }
    
    func dropDownItems(crateArray : [Crate]) -> [String] {
    
        var firstPartArray : [String] = [String]()
        var middlePartArray : [String] = [String]()
        var lastPartArray : [String] = [String]()
        var endArray : [String] = [String]()

        for row in 0...(crateTableView.indexPathForSelectedRow?.row)! {
            
            firstPartArray.append(crateArray[row].title)
            
        }
        for item in crateArray[(crateTableView.indexPathForSelectedRow?.row)!].items {
            
            middlePartArray.append(item.title)
            
        }
        for row in ((crateTableView.indexPathForSelectedRow?.row)! + 1)..<crateArray.count {
            
            lastPartArray.append(crateArray[row].title)
            
        }
        
        endArray.append(contentsOf: firstPartArray)
        endArray.append(contentsOf: middlePartArray)
        endArray.append(contentsOf: lastPartArray)
        
        return endArray
        
    }
    
    func loadTruck() {
        
        
        
    }
    
}
































