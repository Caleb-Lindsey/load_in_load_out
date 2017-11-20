//
//  EquipmentController.swift
//  Load In Load Out
//
//  Created by Caleb Lindsey on 10/17/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit
import AVFoundation

class EquipmentController : CustomViewController, UITableViewDelegate, UITableViewDataSource, AVCaptureMetadataOutputObjectsDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Variables
    var video = AVCaptureVideoPreviewLayer()
    let arrayOfMinutes = Array(0...90)
    var newItemArray : [Item] = [Item]()
    var dataHandle = DataHandle()
    var editCrateMode : Bool = false
    
    let createCrateButton : UIButton = {
        let button = UIButton()
        button.setTitle("New Crate", for: .normal)
        button.backgroundColor = GlobalVariables.grayColor
        button.setTitleColor(UIColor.darkGray, for: .highlighted)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(presentCamera), for: .touchUpInside)
        return button
    }()
    
    let crateTableView : UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = GlobalVariables.yellowColor
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica", size: 35)
        return label
    }()
    
    let typeLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont(name: "Helvetica", size: 25)
        label.textAlignment = .center
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        return label
    }()
    
    let locationButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "location"), for: .normal)
        button.addTarget(self, action: #selector(showlocation), for: .touchUpInside)
        button.adjustsImageWhenHighlighted = true
        return button
    }()
    
    let itemTableView : UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    
    var itemSetupLength : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont(name: "Helvetica", size: 18)
        label.text = "Setup Length:"
        return label
    }()
    
    let itemSetupDescription : UITextView = {
        let textView = UITextView()
        textView.textColor = UIColor.white
        textView.backgroundColor = UIColor.clear
        textView.font = UIFont(name: "Helvetica", size: 15)
        textView.isEditable = false
        textView.layer.borderColor = UIColor.white.cgColor
        textView.layer.borderWidth = 0.3
        return textView
    }()
    
    let editCrateButton : UIButton = {
        let button = UIButton()
        button.setTitle("Edit Crate", for: .normal)
        button.backgroundColor = GlobalVariables.grayColor
        button.setTitleColor(UIColor.darkGray, for: .highlighted)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(editCrate), for: .touchUpInside)
        return button
    }()
    
    let cameraView : UIView = {
        let view = UIView()
        return view
    }()
    
    let dismissButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "xIcon"), for: .normal)
        button.addTarget(self, action: #selector(dismissCamera), for: .touchUpInside)
        return button
    }()
    
    let dimmerView : UIView = {
        let view = UIView()
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        return view
    }()
    
    let dismissMapButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "xIcon"), for: .normal)
        button.addTarget(self, action: #selector(dismissMap), for: .touchUpInside)
        return button
    }()
    
    let dunkMapView : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Dunk_Schematic")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    //*************************************************************************************************************
    
    let newCrateView : UIView = {
        let view = UIView()
        view.backgroundColor = GlobalVariables.grayColor
        view.layer.borderColor = GlobalVariables.yellowColor.cgColor
        view.layer.borderWidth = 3
        return view
    }()
    
    let newCrateLabel : UILabel = {
        let label = UILabel()
        label.textColor = GlobalVariables.yellowColor
        label.font = UIFont(name: "Helvetica", size: 35)
        return label
    }()
    
    let newCrateCodeView : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    let newCrateTypeBar : UISegmentedControl = {
        let controller = UISegmentedControl(items: GlobalVariables.arrayOfTypes)
        controller.selectedSegmentIndex = 0
        controller.tintColor = GlobalVariables.yellowColor
        controller.backgroundColor = GlobalVariables.grayColor
        controller.addTarget(self, action: #selector(selectNewCrateType), for: .valueChanged)
        return controller
    }()
    
    let newCrateItemTitleField : CustomTextField = {
        let textField = CustomTextField()
        textField.textColor = UIColor.white
        textField.attributedPlaceholder = NSAttributedString(string: "Name of item", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        textField.backgroundColor = UIColor.clear
        textField.layer.borderColor = GlobalVariables.yellowColor.cgColor
        textField.layer.borderWidth = 0.4
        return textField
    }()
    
    let newItemSetupDescription : UITextView = {
        let textView = UITextView()
        textView.textColor = UIColor.white
        textView.backgroundColor = UIColor.clear
        textView.font = UIFont(name: "Helvetica", size: 11)
        textView.layer.borderColor = GlobalVariables.yellowColor.cgColor
        textView.layer.borderWidth = 0.3
        textView.text = "(No setup instructions.)"
        return textView
    }()
    
    let newCrateCreateButton : UIButton = {
        let button = UIButton()
        button.setTitle("Create", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .highlighted)
        button.titleLabel?.textAlignment = .center
        button.layer.borderWidth = 0.5
        button.layer.borderColor = GlobalVariables.yellowColor.cgColor
        button.addTarget(self, action: #selector(completeNewCrate), for: .touchUpInside)
        return button
    }()
    
    let newCrateCancelButton : UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .highlighted)
        button.titleLabel?.textAlignment = .center
        button.layer.borderWidth = 0.5
        button.layer.borderColor = GlobalVariables.yellowColor.cgColor
        button.addTarget(self, action: #selector(dismissNewCrateView), for: .touchUpInside)
        return button
    }()
    
    let addItemToCrateButton : UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 0.5
        button.layer.borderColor = GlobalVariables.yellowColor.cgColor
        button.backgroundColor = GlobalVariables.yellowColor
        button.setImage(UIImage(named: "insertArrow"), for: .normal)
        button.adjustsImageWhenHighlighted = true
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(addNewItem), for: .touchUpInside)
        return button
    }()
    
    let newItemTimePicker : UIPickerView = {
        let picker = UIPickerView()
        picker.layer.borderWidth = 0.5
        picker.layer.cornerRadius = 8
        picker.layer.borderColor = GlobalVariables.yellowColor.cgColor
        
        return picker
    }()
    
    let newCrateContentsTable : UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBarHeight = statusBar.frame.height
        let navHeight = self.navigationController?.navigationBar.frame.height
        
        if let window = UIApplication.shared.keyWindow {
        
            // Place dimmer view
            dimmerView.frame = view.frame
            
            // Place create crate button
            createCrateButton.frame = CGRect(x: 0, y: statusBarHeight + navHeight!, width: window.frame.width * (4/10), height: 50)
            view.addSubview(createCrateButton)
            
            // Place crate table view
            crateTableView.frame = CGRect(x: 0, y: createCrateButton.frame.maxY, width: window.frame.width * (4/10), height: window.frame.height - statusBarHeight - navHeight! - 50)
            crateTableView.delegate = self
            crateTableView.dataSource = self
            crateTableView.register(CrateCell.self, forCellReuseIdentifier: "crateCell")
            view.addSubview(crateTableView)
            
            // Place title label
            titleLabel.frame = CGRect(x: crateTableView.frame.maxX + 25, y: statusBarHeight + navHeight! + 25, width: window.frame.width - crateTableView.frame.width - 25 - 25 - 100 - 25, height: 50)
            view.addSubview(titleLabel)
            
            // Place location button
            locationButton.frame = CGRect(x: window.frame.width - 100 - 25, y: statusBarHeight + navHeight! + 25, width: 100, height: 100)
            view.addSubview(locationButton)
            
            // Place item table view
            itemTableView.frame = CGRect(x: titleLabel.frame.origin.x, y: locationButton.frame.maxY + 25, width: window.frame.width - crateTableView.frame.width - 25 - 25, height: 300)
            itemTableView.delegate = self
            itemTableView.dataSource = self
            itemTableView.register(UITableViewCell.self, forCellReuseIdentifier: "itemCell")
            view.addSubview(itemTableView)
            
            // Place type label
            typeLabel.frame = CGRect(x: titleLabel.frame.origin.x, y: titleLabel.frame.maxY, width: titleLabel.frame.width / 2, height: 50)
            view.addSubview(typeLabel)
            
            // Place item setup length
            itemSetupLength.frame = CGRect(x: itemTableView.frame.origin.x, y: itemTableView.frame.maxY + 15, width: itemTableView.frame.width / 2, height: 30)
            view.addSubview(itemSetupLength)
            
            // Place item setup description
            itemSetupDescription.frame = CGRect(x: itemSetupLength.frame.origin.x, y: itemSetupLength.frame.maxY, width: itemTableView.frame.width, height: 300)
            view.addSubview(itemSetupDescription)
            
            // Place add item button
            editCrateButton.frame = CGRect(x: itemSetupDescription.frame.origin.x, y: itemSetupDescription.frame.maxY + 15, width: itemSetupDescription.frame.width, height: 50)
            view.addSubview(editCrateButton)
            
            setupView()
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == crateTableView {
            let cell : CrateCell = crateTableView.dequeueReusableCell(withIdentifier: "crateCell", for: indexPath) as! CrateCell
            cell.crateTitleLabel.text = GlobalVariables.arrayOfCrates[indexPath.row].title
            //cell.textLabel?.textAlignment = .center
            cell.codeImage.image = GlobalVariables.arrayOfCrates[indexPath.row].code
            return cell
        } else if tableView == itemTableView {
            let cell = itemTableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
            cell.textLabel?.text = GlobalVariables.arrayOfCrates[(crateTableView.indexPathForSelectedRow?.row)!].items[indexPath.row].title
            cell.textLabel?.textAlignment = .center
            return cell
        } else {
            let cell = newCrateContentsTable.dequeueReusableCell(withIdentifier: "newItemCell", for: indexPath)
            
            if newItemArray.count != 0 {
                cell.textLabel?.text = newItemArray[indexPath.row].title
            } else {
                cell.textLabel?.text = ""
            }
            
            cell.textLabel?.textAlignment = .center
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == crateTableView {
            return GlobalVariables.arrayOfCrates.count
        } else if tableView == itemTableView {
            return GlobalVariables.arrayOfCrates[(crateTableView.indexPathForSelectedRow?.row)!].items.count
        } else {
            return newItemArray.count
        }
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == crateTableView {
            return 100
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == crateTableView {
            
            // Title label
            titleLabel.text = GlobalVariables.arrayOfCrates[indexPath.row].title
            
            // Type label
            typeLabel.text = GlobalVariables.arrayOfCrates[indexPath.row].type
            typeLabel.backgroundColor = crateColor(crate: GlobalVariables.arrayOfCrates[indexPath.row])
            
            // Item table view
            itemTableView.reloadData()
            
        } else if tableView == itemTableView {
            
            // Item setup length
            itemSetupLength.text = "Setup Length: \(GlobalVariables.arrayOfCrates[(crateTableView.indexPathForSelectedRow?.row)!].items[indexPath.row].setupLength) minutes"
            
            // Item setup description
            itemSetupDescription.text = "\(GlobalVariables.arrayOfCrates[(crateTableView.indexPathForSelectedRow?.row)!].items[indexPath.row].setupInstructions)"
            
        } else {
            print("BABA")
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == crateTableView {
            return "Crates"
        } else {
            return "Items"
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            if tableView == crateTableView {
                GlobalVariables.arrayOfCrates.remove(at: indexPath.row)
                crateTableView.deleteRows(at: [indexPath as IndexPath], with: .fade)
                dataHandle.saveCrate()
            } else if tableView == itemTableView {
                GlobalVariables.arrayOfCrates[(crateTableView.indexPathForSelectedRow?.row)!].items.remove(at: indexPath.row)
                itemTableView.deleteRows(at: [indexPath as IndexPath], with: .fade)
                dataHandle.saveCrate()
            } else {
                newItemArray.remove(at: indexPath.row)
                newCrateContentsTable.deleteRows(at: [indexPath as IndexPath], with: .fade)
            }
        }
    }
    
    @objc func showlocation() {
        
        view.addSubview(dimmerView)
        dunkMapView.layer.opacity = 0
        dunkMapView.frame = locationButton.frame
        dimmerView.addSubview(dunkMapView)
        
        dismissMapButton.frame = CGRect(x: dimmerView.frame.width - 15 - 50, y: 100, width: 50, height: 50)
        dimmerView.addSubview(dismissMapButton)
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            
            self.dunkMapView.layer.opacity = 1
            self.dimmerView.layer.opacity = 1
            self.dunkMapView.frame = self.view.frame
            
            
        }, completion: { (finished: Bool) in
            
            
            
        })
        
    }
    
    @objc func dismissMap() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            
            self.dunkMapView.layer.opacity = 0
            self.dunkMapView.frame = self.locationButton.frame
            self.dimmerView.layer.opacity = 0
            
        }, completion: { (finished: Bool) in
            
            self.dimmerView.removeFromSuperview()
            
        })
    }
    
    func setupView() {
        if GlobalVariables.arrayOfCrates.count != 0 {
            crateTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .none)
            titleLabel.text = GlobalVariables.arrayOfCrates[0].title
            typeLabel.text = GlobalVariables.arrayOfCrates[0].type
            typeLabel.backgroundColor = crateColor(crate: GlobalVariables.arrayOfCrates[0])
        }
    }
    
    func newCrate(crateTitle : String, newCrate : Bool) {
        
        let statusBarHeight = statusBar.frame.height
        let navHeight = self.navigationController?.navigationBar.frame.height
        let tabBarHeight = self.tabBarController?.tabBar.frame.height
        
        // View
        newCrateView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: view.frame.height - statusBarHeight - navHeight! - tabBarHeight!)
        view.addSubview(newCrateView)
        
        // Crate Title
        newCrateLabel.frame = CGRect(x: 15, y: 15, width: newCrateView.frame.width - 100 - 15, height: 50)
        newCrateLabel.text = crateTitle
        newCrateView.addSubview(newCrateLabel)
        
        newCrateCodeView.frame = CGRect(x: newCrateView.frame.width - 15 - 100, y: 15, width: 100, height: 100)
        newCrateView.addSubview(newCrateCodeView)
        
        // Crate Type
        newCrateTypeBar.frame = CGRect(x: newCrateLabel.frame.origin.x, y: newCrateLabel.frame.maxY, width: newCrateView.frame.width - 15 - 15 - 100 - 15, height: 50)
        newCrateView.addSubview(newCrateTypeBar)
        
        // Item Field
        newCrateItemTitleField.frame = CGRect(x: newCrateTypeBar.frame.origin.x, y: newCrateTypeBar.frame.maxY + 15, width: newCrateTypeBar.frame.width / 2 - 60, height: 35)
        newCrateItemTitleField.layer.borderColor = GlobalVariables.yellowColor.cgColor
        newCrateView.addSubview(newCrateItemTitleField)
        
        // Time Picker View
        newItemTimePicker.frame = CGRect(x: newCrateItemTitleField.frame.maxX + 5 , y: newCrateItemTitleField.frame.origin.y, width: 50, height: newCrateItemTitleField.frame.height)
        newItemTimePicker.delegate = self
        newItemTimePicker.dataSource = self
        newCrateView.addSubview(newItemTimePicker)
        
        // Item Setup Description
        newItemSetupDescription.frame = CGRect(x: newCrateItemTitleField.frame.origin.x, y: newCrateItemTitleField.frame.maxY + 15, width: newCrateTypeBar.frame.width / 2, height: newCrateView.frame.height / 2)
        newCrateView.addSubview(newItemSetupDescription)
        
        // Add Item To Crate Button
        addItemToCrateButton.frame = CGRect(x: newItemSetupDescription.frame.maxX + 5 , y: newCrateItemTitleField.frame.origin.y, width: 50, height: newCrateItemTitleField.frame.height + 15 + newItemSetupDescription.frame.height)
        newCrateView.addSubview(addItemToCrateButton)
        
        // Crate Content Table
        newCrateContentsTable.frame = CGRect(x: addItemToCrateButton.frame.maxX + 5, y: addItemToCrateButton.frame.origin.y, width: newCrateView.frame.width - 15 - newItemSetupDescription.frame.width - 5 - 50 - 5 - 15, height: addItemToCrateButton.frame.height)
        newCrateContentsTable.delegate = self
        newCrateContentsTable.dataSource = self
        newCrateContentsTable.register(UITableViewCell.self, forCellReuseIdentifier: "newItemCell")
        newCrateView.addSubview(newCrateContentsTable)
        
        // Cancel Crate Button
        newCrateCancelButton.frame = CGRect(x: newCrateLabel.frame.origin.x, y: newCrateView.frame.height - 50 - 15, width: 100, height: 50)
        newCrateView.addSubview(newCrateCancelButton)
        
        // Create Crate Button
        newCrateCreateButton.frame = CGRect(x: newCrateView.frame.width - 100 - 15, y: newCrateView.frame.height - 50 - 15, width: 100, height: 50)
        newCrateView.addSubview(newCrateCreateButton)
        
        if newCrate {
            
            editCrateMode = false
            newCrateContentsTable.reloadData()

            // Crate Code
            let data = crateTitle.data(using: .ascii, allowLossyConversion: false)
            let filter = CIFilter(name: "CIQRCodeGenerator")
            filter?.setValue(data, forKey: "inputMessage")
            let img = UIImage(ciImage: (filter?.outputImage)!)
            newCrateCodeView.image = img
            
        } else {
            
            editCrateMode = true
            
            newItemArray = GlobalVariables.arrayOfCrates[(crateTableView.indexPathForSelectedRow?.row)!].items
            
            newCrateContentsTable.reloadData()
            
            // Crate Code
            newCrateCodeView.image = GlobalVariables.arrayOfCrates[(crateTableView.indexPathForSelectedRow?.row)!].code
            
            // Crate type
            var count : Int = 0
            for segment in GlobalVariables.arrayOfTypes {
                if GlobalVariables.arrayOfCrates[(crateTableView.indexPathForSelectedRow?.row)!].type == segment {
                    newCrateTypeBar.selectedSegmentIndex = count
                }
                count += 1
            }
            
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            
            self.newCrateView.frame.origin.y = statusBarHeight + navHeight!
            
        }, completion: { (finished: Bool) in
            
            
            
        })
        
    }
    
    @objc func dismissCamera() {
        UIView.animate(withDuration: 0.35, delay: 0, options: .curveEaseOut, animations: {
            
            self.cameraView.frame.origin.y = self.view.frame.height
            
        }, completion: { (finished: Bool) in
            
            self.dismissButton.removeFromSuperview()
            self.cameraView.removeFromSuperview()
            
        })
    }
    
    @objc func presentCamera() {
        
        cameraView.frame = CGRect(x: view.frame.width / 2 - 250, y: view.frame.height, width: 500, height: 500)
        view.addSubview(cameraView)
        
        // Creating Session
        let session = AVCaptureSession()
        
        // Define Capture Device
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        
        do
        {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            session.addInput(input)
        }
        catch
        {
            print("ERROR")
        }
        
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = cameraView.bounds
        video.masksToBounds = true
        video.videoGravity = .resizeAspectFill
        cameraView.layer.addSublayer(video)
        
        session.startRunning()
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            
            self.cameraView.frame.origin.y = self.view.frame.height / 2 - 250
            
        }, completion: { (finished: Bool) in
            
            self.dismissButton.frame = CGRect(x: self.cameraView.frame.width / 2 - 25, y: self.cameraView.frame.height - 15 - 50, width: 50, height: 50)
            self.cameraView.addSubview(self.dismissButton)
            
        })
        
    }
    
    @objc func selectNewCrateType() {
        
        // Leave empty?
        
    }
    
    @objc func dismissNewCrateView() {
        
        newItemArray.removeAll()
        newCrateContentsTable.reloadData()
        newCrateTypeBar.selectedSegmentIndex = 0
        newCrateItemTitleField.text = ""
        newItemTimePicker.selectRow(0, inComponent: 0, animated: true)
        newItemSetupDescription.text = "(No setup instructions.)"
        
        UIView.animate(withDuration: 0.35, delay: 0, options: .curveEaseOut, animations: {
            
            self.newCrateView.frame.origin.y = self.view.frame.height
            
        }, completion: { (finished: Bool) in
            
            
            
        })
        
    }
    
    func metadataOutput(_ captureOutput: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        video.session?.stopRunning()
        if metadataObjects.count != 0 {
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject {
                if object.type == AVMetadataObject.ObjectType.qr {
                    let alert = UIAlertController(title: object.stringValue, message: "Would you like to create a new crate with this code?", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (nil) in
                        self.video.session?.startRunning()
                    }))
                    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (nil) in
                            self.dismissCamera()
                            self.newCrate(crateTitle: object.stringValue!, newCrate: true)
                    }))
                    present(alert, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return arrayOfMinutes.count
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return "1"
        
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label: UILabel
        if let view = view as? UILabel { label = view }
        else { label = UILabel() }
        
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont(name: "My-Custom-Font", size: 20)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.text = "\(arrayOfMinutes[row])m"
        
        return label
    }
    
    @objc func addNewItem() {
        
        if newCrateItemTitleField.text != "" {
            
            newCrateItemTitleField.layer.borderColor = GlobalVariables.yellowColor.cgColor
            let newItem : Item = Item(title: newCrateItemTitleField.text!, setupLength: newItemTimePicker.selectedRow(inComponent: 0), setupInstructions: newItemSetupDescription.text!)
            
            newItemArray.append(newItem)
            
            newCrateItemTitleField.text = ""
            newItemTimePicker.selectRow(0, inComponent: 0, animated: true)
            newItemSetupDescription.text = "(No setup instructions.)"
            
            newCrateContentsTable.reloadData()
            
        } else {
            
            let alert = UIAlertController(title: "Insufficiant Data", message: "Missing item name.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            
            newCrateItemTitleField.layer.borderColor = UIColor.red.cgColor
            
        }
    }
    
    @objc func completeNewCrate() {
        
        if newCrateLabel.text != "" && newItemArray.count != 0 || editCrateMode == true {
            
            if editCrateMode {
                GlobalVariables.arrayOfCrates[(crateTableView.indexPathForSelectedRow?.row)!].items = newItemArray
                GlobalVariables.arrayOfCrates[(crateTableView.indexPathForSelectedRow?.row)!].type = GlobalVariables.arrayOfTypes[newCrateTypeBar.selectedSegmentIndex]
                
            } else {
                let newCrate : Crate = Crate(title: newCrateLabel.text!, items: newItemArray, type: GlobalVariables.arrayOfTypes[newCrateTypeBar.selectedSegmentIndex], code: newCrateCodeView.image!, location: 0)
                GlobalVariables.arrayOfCrates.append(newCrate)
            }
            
            dataHandle.saveCrate()
            
            editCrateMode = false
            
            crateTableView.reloadData()
            
            dismissNewCrateView()
            
        } else {
            let alert = UIAlertController(title: "Insufficiant Data", message: "Missing items.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func editCrate() {
        
        newCrate(crateTitle: GlobalVariables.arrayOfCrates[(crateTableView.indexPathForSelectedRow?.row)!].title, newCrate: false)
        
    }
    
    func crateColor(crate : Crate) -> UIColor {
        
        var color : UIColor = UIColor.red
        
        switch crate.type {
        case GlobalVariables.arrayOfTypes[0]: // Lighting
            color = UIColor.yellow
        case GlobalVariables.arrayOfTypes[1]: // Band
            color = UIColor.green
        case GlobalVariables.arrayOfTypes[2]: // Stage
            color = UIColor.purple
        case GlobalVariables.arrayOfTypes[3]: // Audio
            color = UIColor.blue
        case GlobalVariables.arrayOfTypes[4]: // Visual
            color = UIColor.orange
        default:
            color = UIColor.clear // ERROR
        }
        
        return color
        
    }
    
}



















































