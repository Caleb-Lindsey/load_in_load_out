//
//  ItemController.swift
//  Load In Load Out
//
//  Created by Caleb Lindsey on 11/15/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit
import AVFoundation

class ItemController : CustomViewController, UITableViewDataSource, UITableViewDelegate, AVCaptureMetadataOutputObjectsDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //Variables
    var video = AVCaptureVideoPreviewLayer()
    let arrayOfMinutes = Array(0...90)
    let dataHandle : DataHandle = DataHandle()
    
    let createItemButton : UIButton = {
        let button = UIButton()
        button.setTitle("New Item", for: .normal)
        button.backgroundColor = GlobalVariables.grayColor
        button.setTitleColor(UIColor.darkGray, for: .highlighted)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(presentCamera), for: .touchUpInside)
        return button
    }()
    
    let itemTableView : UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = GlobalVariables.yellowColor
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica", size: 35)
        return label
    }()
    
    var itemSetupLength : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont(name: "Helvetica", size: 18)
        label.text = "Setup Length:"
        return label
    }()
    
    let itemLocation : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont(name: "Helvetica", size: 18)
        label.text = "Location: "
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
    
    //**********************************************************************
    
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
    
    let newItemView : UIView = {
        let view = UIView()
        view.backgroundColor = GlobalVariables.grayColor
        view.layer.borderColor = GlobalVariables.yellowColor.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    let newItemTitle : UILabel = {
        let label = UILabel()
        label.textColor = GlobalVariables.yellowColor
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica", size: 35)
        return label
    }()
    
    let newItemTimePicker : UIPickerView = {
        let picker = UIPickerView()
        picker.layer.borderWidth = 0.5
        picker.layer.cornerRadius = 8
        picker.layer.borderColor = GlobalVariables.yellowColor.cgColor
        return picker
    }()
    
    let newItemSetupView : CustomTextView = {
        let textView = CustomTextView()
        textView.textColor = UIColor.white
        textView.backgroundColor = UIColor.clear
        textView.font = UIFont(name: "Helvetica", size: 15)
        textView.layer.borderColor = GlobalVariables.yellowColor.cgColor
        textView.layer.borderWidth = 0.3
        textView.text = "(No setup instructions.)"
        return textView
    }()
    
    let cancelNewItemButton : UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.backgroundColor = GlobalVariables.grayColor
        button.setTitleColor(UIColor.darkGray, for: .highlighted)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = GlobalVariables.yellowColor.cgColor
        button.addTarget(self, action: #selector(dismissNewItem), for: .touchUpInside)
        return button
    }()
    
    let doneNewItemButton : UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.backgroundColor = GlobalVariables.grayColor
        button.setTitleColor(UIColor.darkGray, for: .highlighted)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = GlobalVariables.yellowColor.cgColor
        button.addTarget(self, action: #selector(completeNewItem), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBarHeight = statusBar.frame.height
        let navHeight = self.navigationController?.navigationBar.frame.height
        
        // Place create item button
        createItemButton.frame = CGRect(x: 0, y: statusBarHeight + navHeight!, width: view.frame.width * (4/10), height: 50)
        view.addSubview(createItemButton)
        
        // Place item table view
        itemTableView.frame = CGRect(x: 0, y: createItemButton.frame.maxY, width: view.frame.width * (4/10), height: view.frame.height - statusBarHeight - navHeight! - 50)
        itemTableView.delegate = self
        itemTableView.dataSource = self
        itemTableView.register(CrateCell.self, forCellReuseIdentifier: "itemCell")
        view.addSubview(itemTableView)
        
        // Place title label
        titleLabel.frame = CGRect(x: itemTableView.frame.maxX + 25, y: statusBarHeight + navHeight! + 25, width: view.frame.width - itemTableView.frame.width - 15 - 15, height: 50)
        view.addSubview(titleLabel)
        
        // Place setup label
        itemSetupLength.frame = CGRect(x: titleLabel.frame.origin.x, y: titleLabel.frame.maxY + 25, width: titleLabel.frame.width, height: 30)
        view.addSubview(itemSetupLength)
        
        // Place setupview
        itemSetupDescription.frame = CGRect(x: itemSetupLength.frame.origin.x, y: itemSetupLength.frame.maxY + 15, width: itemSetupLength.frame.width, height: 400)
        view.addSubview(itemSetupDescription)
        
        // Place setup location
        itemLocation.frame = CGRect(x: itemSetupDescription.frame.origin.x, y: itemSetupDescription.frame.maxY + 15, width: 200, height: 50)
        view.addSubview(itemLocation)
        
        
        setupView()
        
    }
    
    func setupView() {
        
        if GlobalVariables.arrayOfLoadables != [] {
            itemTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .none)
            titleLabel.text = GlobalVariables.arrayOfLoadables[0].title
            itemSetupLength.text = "Setup Length: \(GlobalVariables.arrayOfLoadables[0].setupLength)"
            itemSetupDescription.text = GlobalVariables.arrayOfLoadables[0].setupInstructions
            itemLocation.text = "Location: \(GlobalVariables.arrayOfLoadables[0].location)"
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CrateCell = itemTableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! CrateCell
        cell.crateTitleLabel.text = GlobalVariables.arrayOfLoadables[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if GlobalVariables.arrayOfLoadables != [] {
            return GlobalVariables.arrayOfLoadables.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Title label
        titleLabel.text = GlobalVariables.arrayOfLoadables[indexPath.row].title
        
        // Setup length
        itemSetupLength.text = "Setup Length: \(GlobalVariables.arrayOfLoadables[indexPath.row].setupLength)"
        
        // Setup Description
        itemSetupDescription.text = GlobalVariables.arrayOfLoadables[indexPath.row].setupInstructions
        
        // Item Location
        itemLocation.text = "Location: \(GlobalVariables.arrayOfLoadables[indexPath.row].location)"
        
        
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            if tableView == itemTableView {
                GlobalVariables.arrayOfLoadables.remove(at: indexPath.row)
                itemTableView.deleteRows(at: [indexPath as IndexPath], with: .fade)
                dataHandle.saveLoadableItem()
            }
        }
    }
    
    @objc func newItem(itemTitle : String, newItem : Bool) {
        
        let statusBarHeight = statusBar.frame.height
        let navHeight = self.navigationController?.navigationBar.frame.height
        let tabBarHeight = self.tabBarController?.tabBar.frame.height
        
        // New Item View
        newItemView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: view.frame.height - statusBarHeight - navHeight! - tabBarHeight!)
        view.addSubview(newItemView)
        
        // New Item Title
        newItemTitle.frame = CGRect(x: 15, y: 15, width: newItemView.frame.width - 15 - 15, height: 50)
        newItemView.addSubview(newItemTitle)
        
        // New Item Setup Description
        newItemSetupView.frame = CGRect(x: newItemTitle.frame.origin.x, y: newItemTitle.frame.maxY + 15, width: newItemView.frame.width / 2 - 15 - 15, height: newItemView.frame.width / 2 - 15 - 15)
        newItemView.addSubview(newItemSetupView)
        
        // New Item Picker
        newItemTimePicker.frame = CGRect(x: newItemSetupView.frame.maxX + 15, y: newItemSetupView.frame.origin.y, width: 50, height: 50)
        newItemTimePicker.delegate = self
        newItemTimePicker.dataSource = self
        newItemView.addSubview(newItemTimePicker)
        
        // Cancel Button
        cancelNewItemButton.frame = CGRect(x: newItemSetupView.frame.origin.x, y: newItemSetupView.frame.maxY + 15, width: 100, height: 50)
        newItemView.addSubview(cancelNewItemButton)
        
        // Done Button
        doneNewItemButton.frame = CGRect(x: newItemSetupView.frame.maxX - 100, y: newItemSetupView.frame.maxY + 15, width: 100, height: 50)
        newItemView.addSubview(doneNewItemButton)
        
        if newItem {
            
            // Title
            newItemTitle.text = itemTitle
            
        } else {
            // This is for editing items
        }
        
        
        
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            
            self.newItemView.frame.origin.y = statusBarHeight + navHeight!
            
        }, completion: { (finished : Bool) in
            
            
            
        })
        
    }
    
    @objc func dismissNewItem() {
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            
            self.newItemView.frame.origin.y = self.view.frame.height
            
        }, completion: { (finished : Bool) in
            
            self.newItemTimePicker.selectRow(0, inComponent: 0, animated: true)
            self.newItemSetupView.text = "(No setup instructions.)"
            self.newItemView.removeFromSuperview()
            
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
            self.dismissButton.frame = CGRect(x: self.cameraView.frame.width / 2 - 25, y: self.cameraView.frame.height - 15 - 50, width: 50, height: 50)
            self.cameraView.addSubview(self.dismissButton)
            
        }, completion: { (finished: Bool) in
            
            
            
        })
        
    }
    
    func metadataOutput(_ captureOutput: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        video.session?.stopRunning()
        if metadataObjects.count != 0 {
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject {
                if object.type == AVMetadataObject.ObjectType.qr {
                    let alert = UIAlertController(title: object.stringValue, message: "Would you like to create a new item with this code?", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (nil) in
                        self.video.session?.startRunning()
                    }))
                    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (nil) in
                        self.dismissCamera()
                        self.newItem(itemTitle: object.stringValue!, newItem: true)
                    }))
                    present(alert, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    @objc func dismissCamera() {
        UIView.animate(withDuration: 0.35, delay: 0, options: .curveEaseOut, animations: {
            
            self.cameraView.frame.origin.y = self.view.frame.height
            self.itemTableView.reloadData()
            
        }, completion: { (finished: Bool) in
            
            self.dismissButton.removeFromSuperview()
            self.cameraView.removeFromSuperview()
            
        })
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
    
    @objc func completeNewItem() {
        
        if newItemSetupView.text == "" {
            newItemSetupView.text = "(No setup instructions.)"
        }
        
        let newItem = LoadableItem(title: newItemTitle.text!, setupLength: newItemTimePicker.selectedRow(inComponent: 0), setupInstructions: newItemSetupView.text!, location: 0)
        GlobalVariables.arrayOfLoadables.append(newItem)
        dataHandle.saveLoadableItem()
        dismissNewItem()
        itemTableView.reloadData()
        
    }
    
}
    




















