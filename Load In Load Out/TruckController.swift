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
    var newTruckCrateArray : [Crate] = [Crate]()
    var dataHandle = DataHandle()
    
    let createTruckButton : UIButton = {
        let button = UIButton()
        button.setTitle("New Truck", for: .normal)
        button.backgroundColor = GlobalVariables.grayColor
        button.setTitleColor(UIColor.darkGray, for: .highlighted)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(newTruck), for: .touchUpInside)
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
    
    let loadTruckButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = GlobalVariables.grayColor
        button.setTitleColor(UIColor.darkGray, for: .highlighted)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    let editTruckButton : UIButton = {
        let button = UIButton()
        button.setTitle("Edit Truck", for: .normal)
        button.backgroundColor = GlobalVariables.grayColor
        button.setTitleColor(UIColor.darkGray, for: .highlighted)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    let duplicateTruckButton : UIButton = {
        let button = UIButton()
        button.setTitle("Duplicate Truck", for: .normal)
        button.backgroundColor = GlobalVariables.grayColor
        button.setTitleColor(UIColor.darkGray, for: .highlighted)
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
    
    //************************************************************************************************************************************************************************************************
    
    let newTruckView : UIView = {
        let view = UIView()
        view.backgroundColor = GlobalVariables.grayColor
        view.layer.borderColor = GlobalVariables.yellowColor.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    let newTruckTitleField : CustomTextField = {
        let textField = CustomTextField()
        textField.textColor = UIColor.white
        textField.attributedPlaceholder = NSAttributedString(string: "Enter Truck Title", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        textField.backgroundColor = UIColor.clear
        textField.layer.borderColor = GlobalVariables.yellowColor.cgColor
        textField.layer.borderWidth = 0.4
        return textField
    }()
    
    let newTruckDatePicker : UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.setValue(GlobalVariables.yellowColor, forKeyPath: "textColor")
        picker.minimumDate = Date()
        return picker
    }()
    
    let newTruckCaptainField : CustomTextField = {
        let textField = CustomTextField()
        textField.textColor = UIColor.white
        textField.attributedPlaceholder = NSAttributedString(string: "Enter Captain Name", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        textField.backgroundColor = UIColor.clear
        textField.layer.borderColor = GlobalVariables.yellowColor.cgColor
        textField.layer.borderWidth = 0.4
        return textField
    }()
    
    let newTruckAllCratesTable : UITableView = {
        let tableView = UITableView()
        tableView.allowsMultipleSelection = true
        return tableView
    }()
    
    let newTruckCrateTable : UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false
        return tableView
    }()
    
    let newTruckNotesView : UITextView = {
        let textView = UITextView()
        textView.textColor = UIColor.white
        textView.backgroundColor = UIColor.clear
        textView.font = UIFont(name: "Helvetica", size: 15)
        textView.layer.borderColor = GlobalVariables.yellowColor.cgColor
        textView.layer.borderWidth = 0.3
        textView.text = "Truck Notes: "
        return textView
    }()
    
    let cancelNewTruckButton : UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.backgroundColor = GlobalVariables.grayColor
        button.setTitleColor(UIColor.darkGray, for: .highlighted)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = GlobalVariables.yellowColor.cgColor
        button.addTarget(self, action: #selector(dismissNewTruckView), for: .touchUpInside)
        return button
    }()
    
    let doneNewTruckButton : UIButton = {
        let button = UIButton()
        button.setTitle("Complete Truck", for: .normal)
        button.backgroundColor = GlobalVariables.grayColor
        button.setTitleColor(UIColor.darkGray, for: .highlighted)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = GlobalVariables.yellowColor.cgColor
        button.addTarget(self, action: #selector(completeTruck), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataHandle.fillItemData()
        dataHandle.fillCrateData()
        dataHandle.fillTruckData()
        
        let statusBarHeight = statusBar.frame.height
        let navHeight = self.navigationController?.navigationBar.frame.height
        
        truckTableView.selectRow(at: IndexPath(row: 0, section: 0) , animated: true, scrollPosition: .none)
        truckTableView.cellForRow(at: IndexPath(row: 0, section: 0))?.isSelected = true
        
        if let window = UIApplication.shared.keyWindow {
            
            // Place load truck button
            createTruckButton.frame = CGRect(x: 0, y: statusBarHeight + navHeight!, width: window.frame.width * (4/10), height: 50)
            view.addSubview(createTruckButton)
            
            // Place truck table view
            truckTableView.frame = CGRect(x: 0, y: createTruckButton.frame.maxY, width: createTruckButton.frame.width, height: window.frame.height - statusBarHeight - navHeight! - createTruckButton.frame.height)
            truckTableView.delegate = self
            truckTableView.dataSource = self
            truckTableView.register(TruckCell.self, forCellReuseIdentifier: "truckCell")
            view.addSubview(truckTableView)
            
            // Place title label
            truckTitleLable.frame = CGRect(x: truckTableView.frame.maxX + 25, y: statusBarHeight + navHeight! + 25, width: window.frame.width - truckTableView.frame.width - 25 - 25, height: 40)
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
            truckNotesView.frame = CGRect(x: crateTableView.frame.origin.x, y: crateTableView.frame.maxY + 15, width: view.frame.width - truckTableView.frame.width - 25 - 25, height: 150)
            view.addSubview(truckNotesView)
            
            // Place load truck button
            loadTruckButton.frame = CGRect(x: truckNotesView.frame.origin.x, y: truckNotesView.frame.maxY + 15, width: truckNotesView.frame.width, height: 50)
            view.addSubview(loadTruckButton)
            
            // Place edit truck button
            editTruckButton.frame = CGRect(x: loadTruckButton.frame.origin.x, y: loadTruckButton.frame.maxY + 15, width: loadTruckButton.frame.width / 2 - 7.5, height: 50)
            view.addSubview(editTruckButton)
            
            // Place duplicate truck button
            duplicateTruckButton.frame = CGRect(x: editTruckButton.frame.maxX + 15, y: editTruckButton.frame.origin.y, width: editTruckButton.frame.width, height: 50)
            view.addSubview(duplicateTruckButton)
            
            // Place captian label
            captainLabel.frame = CGRect(x: editTruckButton.frame.origin.x, y: editTruckButton.frame.maxY + 5, width: truckNotesView.frame.width, height: 25)
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
        } else if tableView == itemTableView {
            let cell = itemTableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
            cell.textLabel?.text = GlobalVariables.arrayOfTrucks[(truckTableView.indexPathForSelectedRow?.row)!].crates[(crateTableView.indexPathForSelectedRow?.row)!].items[indexPath.row].title
            cell.textLabel?.textAlignment = .center
            return cell
        } else if tableView == newTruckAllCratesTable {
            let cell : CrateCell = newTruckAllCratesTable.dequeueReusableCell(withIdentifier: "allCratesCell", for: indexPath) as! CrateCell
            cell.crateTitleLabel.text = GlobalVariables.arrayOfCrates[indexPath.row].title
            cell.codeImage.image = GlobalVariables.arrayOfCrates[indexPath.row].code
            return cell
        } else {
            let cell : CrateCell = newTruckCrateTable.dequeueReusableCell(withIdentifier: "newCrateCell", for: indexPath) as! CrateCell
            cell.crateTitleLabel.text = newTruckCrateArray[indexPath.row].title
            cell.codeImage.image = newTruckCrateArray[indexPath.row].code
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == truckTableView {
            return GlobalVariables.arrayOfTrucks.count
        } else if tableView == crateTableView {
            return GlobalVariables.arrayOfTrucks[(truckTableView.indexPathForSelectedRow?.row)!].crates.count
        } else if tableView == itemTableView {
            return GlobalVariables.arrayOfTrucks[(truckTableView.indexPathForSelectedRow?.row)!].crates[(crateTableView.indexPathForSelectedRow?.row)!].items.count
        } else if tableView == newTruckAllCratesTable {
            return GlobalVariables.arrayOfCrates.count
        } else {
            return newTruckCrateArray.count
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
            
            let date = GlobalVariables.arrayOfTrucks[(truckTableView.indexPathForSelectedRow?.row)!].date
            let month = Calendar.current.component(.month, from: date)
            let day = Calendar.current.component(.day, from: date)
            let year = Calendar.current.component(.year, from: date)
            dateLabel.text = "\(month) • \(day) • \(year)"
            
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
            
        } else { // tableView == newTruckAllCratesTable
            
            newTruckCrateArray.append(GlobalVariables.arrayOfCrates[indexPath.row])
            newTruckCrateTable.reloadData()
            
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == truckTableView {
            return "Trucks"
        } else if tableView == crateTableView {
            return "Crates"
        } else if tableView == itemTableView {
            return "Items in this Crate"
        } else if tableView == newTruckAllCratesTable {
            return "All Crates"
        } else {
            return "Crates In This Truck"
        }
    }
    
    func setupView() {
        if GlobalVariables.arrayOfTrucks.count != 0 {
            truckTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .none)
            crateTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .none)
            truckTitleLable.text = GlobalVariables.arrayOfTrucks[0].title
            truckNotesView.text = GlobalVariables.arrayOfTrucks[0].notes
            captainLabel.text = "Captain: \(GlobalVariables.arrayOfTrucks[0].captain)"
            
            let date = GlobalVariables.arrayOfTrucks[0].date
            let month = Calendar.current.component(.month, from: date)
            let day = Calendar.current.component(.day, from: date)
            let year = Calendar.current.component(.year, from: date)
            dateLabel.text = "\(month) • \(day) • \(year)"
            
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
    
    @objc func newTruck() {
        
        let statusBarHeight = statusBar.frame.height
        let navHeight = self.navigationController?.navigationBar.frame.height
        let tabBarHeight = self.tabBarController?.tabBar.frame.height

        
        // New Truck View
        newTruckView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: view.frame.height - statusBarHeight - navHeight! - tabBarHeight!)
        view.addSubview(newTruckView)
        
        // New Truck Title
        newTruckTitleField.frame = CGRect(x: 15, y: 15, width: newTruckView.frame.width / 2 - 7.5 - 15, height: 30)
        newTruckView.addSubview(newTruckTitleField)
        
        // New Truck Captain
        newTruckCaptainField.frame = CGRect(x: newTruckTitleField.frame.origin.x, y: newTruckTitleField.frame.maxY + 15, width: newTruckTitleField.frame.width, height: newTruckTitleField.frame.height)
        newTruckView.addSubview(newTruckCaptainField)
        
        // New Truck Date
        newTruckDatePicker.frame = CGRect(x: newTruckTitleField.frame.maxX + 15, y: newTruckTitleField.frame.origin.y, width: newTruckTitleField.frame.width, height: newTruckTitleField.frame.height + newTruckCaptainField.frame.height + 15)
        newTruckView.addSubview(newTruckDatePicker)
        
        // New Truck Notes
        newTruckNotesView.frame = CGRect(x: newTruckTitleField.frame.maxX + 15, y: newTruckDatePicker.frame.maxY + 15, width: newTruckTitleField.frame.width, height: 200)
        newTruckView.addSubview(newTruckNotesView)
        
        // All Crates Table
        newTruckAllCratesTable.frame = CGRect(x: newTruckCaptainField.frame.origin.x, y: newTruckCaptainField.frame.maxY + 15, width: newTruckTitleField.frame.width, height: newTruckView.frame.height - 15 - 50 - 15 - 15 - 30 - 15 - 30 - 15)
        newTruckAllCratesTable.delegate = self
        newTruckAllCratesTable.dataSource = self
        newTruckAllCratesTable.register(CrateCell.self, forCellReuseIdentifier: "allCratesCell")
        newTruckView.addSubview(newTruckAllCratesTable)
        
        // New Truck Crate Table
        newTruckCrateTable.frame = CGRect(x: newTruckAllCratesTable.frame.maxX + 15, y: newTruckNotesView.frame.maxY + 15, width: newTruckAllCratesTable.frame.width, height: 450)
        newTruckCrateTable.delegate = self
        newTruckCrateTable.dataSource = self
        newTruckCrateTable.register(CrateCell.self, forCellReuseIdentifier: "newCrateCell")
        newTruckView.addSubview(newTruckCrateTable)
        
        // New Truck Complete Button
        doneNewTruckButton.frame = CGRect(x: newTruckCrateTable.frame.origin.x, y: newTruckCrateTable.frame.maxY + 5, width: newTruckView.frame.width - 15 - newTruckTitleField.frame.width - 15 - 15 , height: newTruckView.frame.height - 15 - newTruckDatePicker.frame.height - 15 - 200 - 15 - 450 - 5 - 15 - 50 - 15)
        newTruckView.addSubview(doneNewTruckButton)
        
        // Cancel Button
        cancelNewTruckButton.frame = CGRect(x: 15, y: newTruckView.frame.height - 15 - 50, width: 100, height: 50)
        newTruckView.addSubview(cancelNewTruckButton)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            
            self.newTruckView.frame.origin.y = statusBarHeight + navHeight!
            
        }, completion: { (finished : Bool) in
            
            
            
        })
        
    }
    
    @objc func dismissNewTruckView() {
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            
            self.newTruckView.frame.origin.y = self.view.frame.height
            
        }, completion: { (finished : Bool) in
            
            self.newTruckCrateArray.removeAll()
            self.newTruckCrateTable.reloadData()
            self.newTruckTitleField.text = ""
            self.newTruckCaptainField.text = ""
            self.newTruckNotesView.text = "Truck Notes: "
            self.newTruckDatePicker.setDate(Date(), animated: false)
            self.newTruckAllCratesTable.reloadData()
            self.newTruckView.removeFromSuperview()
            
        })
        
    }
    
    @objc func completeTruck() {
        
        var alertMessage : String = ""
        var noErrors : Bool = true
        
        if newTruckTitleField.text == "" {
            noErrors = false
            newTruckTitleField.layer.borderColor = UIColor.red.cgColor
            alertMessage.append("- Missing Truck Title\n")
        } else {
            newTruckTitleField.layer.borderColor = GlobalVariables.yellowColor.cgColor
        }
        if newTruckCaptainField.text == "" {
            noErrors = false
            newTruckCaptainField.layer.borderColor = UIColor.red.cgColor
            alertMessage.append("- Missing Captain Name\n")
        } else {
            newTruckCaptainField.layer.borderColor = GlobalVariables.yellowColor.cgColor
        }
        if newTruckCrateArray.count == 0 {
            noErrors = false
            newTruckCrateTable.layer.borderColor = UIColor.red.cgColor
            newTruckCrateTable.layer.borderWidth = 2
            alertMessage.append("- No Crates In Truck")
        } else {
            newTruckCrateTable.layer.borderWidth = 0
        }
        
        if noErrors {
            
            let newTruck : Truck = Truck(title: newTruckTitleField.text!, captain: newTruckCaptainField.text!, crates: newTruckCrateArray, date: newTruckDatePicker.date, notes: newTruckNotesView.text!, loaded: false)
            GlobalVariables.arrayOfTrucks.append(newTruck)
            dataHandle.saveTruck()
            truckTableView.reloadData()
            dismissNewTruckView()
            
        } else {
            let alert = UIAlertController(title: "Missing Data", message: alertMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
        
    }
    
}
































