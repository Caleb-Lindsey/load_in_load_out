//
//  LoadTruckController.swift
//  Load In Load Out
//
//  Created by Caleb Lindsey on 11/7/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit
import AVFoundation

class LoadTruckController : CustomViewController, UITableViewDelegate, UITableViewDataSource, AVCaptureMetadataOutputObjectsDelegate {
    
    // Variable
    var truck : Truck!
    var video = AVCaptureVideoPreviewLayer()
    var checkCrate : Crate = Crate()
    var crateLoadedCount : Int = 0
    let dataHandle : DataHandle = DataHandle()
    var selectedRow : Int = Int()
    var navTitle : String = String()
    
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
        label.textAlignment = .right
        return label
    }()
    
    let cameraView : UIView = {
        let view = UIView()
        view.layer.borderColor = GlobalVariables.yellowColor.cgColor
        view.layer.borderWidth = 2
        view.layer.masksToBounds = true
        return view
    }()
    
    let crateTableView : UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    let crateView : UIView = {
        let view = UIView()
        view.backgroundColor = GlobalVariables.grayColor
        view.layer.borderColor = GlobalVariables.yellowColor.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    let loadButton : UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.darkGray, for: .highlighted)
        button.titleLabel?.textAlignment = .center
        button.layer.borderWidth = 0.5
        button.layer.borderColor = GlobalVariables.yellowColor.cgColor
        button.addTarget(self, action: #selector(loadInCrate), for: .touchUpInside)
        return button
    }()
    
    let cancelButton : UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.red, for: .normal)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .highlighted)
        button.titleLabel?.textAlignment = .center
        button.layer.borderWidth = 0.5
        button.layer.borderColor = GlobalVariables.yellowColor.cgColor
        button.addTarget(self, action: #selector(dismissCrateView), for: .touchUpInside)
        return button
    }()
    
    let crateStatusLabel : UILabel = {
        let label = UILabel()
        label.textColor = GlobalVariables.yellowColor
        label.font = UIFont(name: "Helvetica", size: 30)
        label.textAlignment = .center
        return label
    }()
    
    let checkTableView : UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false
        return tableView
    }()
    
    let completedTruckView : UIView = {
        let view = UIView()
        view.backgroundColor = GlobalVariables.grayColor
        view.layer.borderColor = GlobalVariables.yellowColor.cgColor
        view.layer.borderWidth = 4
        return view
    }()
    
    let completeLabel : UILabel = {
        let label = UILabel()
        label.textColor = GlobalVariables.yellowColor
        label.font = UIFont(name: "Helvetica", size: 50)
        label.textAlignment = .center
        return label
    }()
    
    let completeButton : UIButton = {
        let button = UIButton()
        button.setTitle("Okay", for: .normal)
        button.backgroundColor = GlobalVariables.grayColor
        button.setTitleColor(UIColor.darkGray, for: .highlighted)
        button.setTitleColor(GlobalVariables.yellowColor, for: .normal)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = GlobalVariables.yellowColor.cgColor
        button.addTarget(self, action: #selector(okayButton), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    init(truck : Truck) {
        self.truck = truck
        truckTitleLable.text = truck.title
        
        if truck.loaded {
            completeLabel.text = "Unloading Complete!"
            loadButton.setTitle("Load Out", for: .normal)
            navTitle = "Unload Truck"
        } else {
            completeLabel.text = "Loading Complete!"
            loadButton.setTitle("Load In", for: .normal)
            navTitle = "Load Truck"
        }
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = navTitle
        let statusBarHeight = statusBar.frame.height
        let navHeight = self.navigationController?.navigationBar.frame.height
        let tabBarHeight = self.tabBarController?.tabBar.frame.height
        
        // Place truck title
        truckTitleLable.frame = CGRect(x: 15, y: statusBarHeight + navHeight! + 15, width: view.frame.width / 2, height: 50)
        view.addSubview(truckTitleLable)
        
        // Place date label
        let date = truck.date
        let month = Calendar.current.component(.month, from: date)
        let day = Calendar.current.component(.day, from: date)
        let year = Calendar.current.component(.year, from: date)
        dateLabel.text = "\(month) • \(day) • \(year)"
        dateLabel.frame = CGRect(x: view.frame.width - 15 - 300, y: truckTitleLable.frame.origin.y, width: 300, height: 50)
        view.addSubview(dateLabel)
        
        // Place camera view
        cameraView.frame = CGRect(x: 15, y: truckTitleLable.frame.maxY + 15, width: view.frame.width / 2 - 15 - 15, height: 450)
        view.addSubview(cameraView)
        presentCamera()

        // Place crate table view
        crateTableView.frame = CGRect(x: view.frame.width / 2 + 15, y: dateLabel.frame.maxY + 15, width: view.frame.width / 2 - 15 - 15, height: 450)
        crateTableView.delegate = self
        crateTableView.dataSource = self
        crateTableView.register(CrateCell.self, forCellReuseIdentifier: "crateCell")
        view.addSubview(crateTableView)
        
        // Place Crate View Slider
        crateView.frame = CGRect(x: 0, y: cameraView.frame.height, width: cameraView.frame.width, height: cameraView.frame.height)
        cameraView.addSubview(crateView)
        
        // Place yes button
        loadButton.frame = CGRect(x: crateView.frame.width - 15 - 100, y: 15, width: 100, height: 30)
        crateView.addSubview(loadButton)
        
        // Place cancel button
        cancelButton.frame = CGRect(x: 15, y: 15, width: 100, height: 30)
        crateView.addSubview(cancelButton)
        
        // Place crate status label
        crateStatusLabel.frame = CGRect(x: cancelButton.frame.origin.x, y: cancelButton.frame.maxY + 15, width: crateView.frame.width - 15 - 15, height: 40)
        crateView.addSubview(crateStatusLabel)
        
        // Place check table view
        checkTableView.frame = CGRect(x: cancelButton.frame.origin.x, y: crateStatusLabel.frame.maxY + 5, width: crateStatusLabel.frame.width, height: crateView.frame.height - 15 - 30 - 5 - 40 - 15 - 15)
        checkTableView.delegate = self
        checkTableView.dataSource = self
        checkTableView.register(CrateCell.self, forCellReuseIdentifier: "checkCell")
        crateView.addSubview(checkTableView)
        
        // Place complete truck view
        completedTruckView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: view.frame.height - statusBarHeight - navHeight! - tabBarHeight!)
        view.addSubview(completedTruckView)
        
        // Place complete label
        completeLabel.frame = CGRect(x: 0, y: completedTruckView.frame.height / 2 - 50, width: completedTruckView.frame.width, height: 100)
        completedTruckView.addSubview(completeLabel)
        
        // Place complete button
        completeButton.frame = CGRect(x: 0, y: completeLabel.frame.maxY + 15, width: 200, height: 50)
        completeButton.center.x = completeLabel.center.x
        completedTruckView.addSubview(completeButton)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == crateTableView {
            return truck.crates.count
        } else {
            return checkCrate.items.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == crateTableView {
            let cell : CrateCell = crateTableView.dequeueReusableCell(withIdentifier: "crateCell", for: indexPath) as! CrateCell
            cell.crateTitleLabel.text = truck.crates[indexPath.row].title
            cell.codeImage.image = truck.crates[indexPath.row].code
            cell.contentView.layer.opacity = 0.2
            return cell
        } else {
            let cell = checkTableView.dequeueReusableCell(withIdentifier: "checkCell", for: indexPath)
            cell.textLabel?.text = checkCrate.items[indexPath.row].title
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == crateTableView {
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == crateTableView {
            if truck.loaded {
                return "Crates to Unload"
            } else {
                return "Crates to Load"
            }
        } else {
            return "Check Crate Contents."
        }
    }
    
    func presentCamera() {
        
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
        
    }
    
    func metadataOutput(_ captureOutput: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if metadataObjects.count != 0 {
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject {
                if object.type == AVMetadataObject.ObjectType.qr {
                    var count : Int = 0
                    for crate in truck.crates {
                        if crate.title == object.stringValue {
                            let thisCell : CrateCell = crateTableView.cellForRow(at: IndexPath(row: count, section: 0)) as! CrateCell
                            video.session?.stopRunning()
                            print("SCAN")
                            presentCrateView(crate: crate, cell: thisCell)
                            return
                        }
                        count += 1
                    }
                    
                }
            }
        }
        
    }
    
    func presentCrateView(crate : Crate, cell : UITableViewCell) {
        
        checkCrate = crate
        checkTableView.reloadData()
        crateStatusLabel.text = checkCrate.title
        
        UIView.animate(withDuration: 0.35, delay: 0.6, options: .curveEaseOut, animations: {
            
            self.crateView.frame.origin.y = 0
            
            }, completion: { (finished: Bool) in
                
                
                
                })
        
    }
    
    @objc func dismissCrateView() {
        
        video.session?.startRunning()
        
        UIView.animate(withDuration: 0.35, delay: 0, options: .curveEaseOut, animations: {
            
            self.crateView.frame.origin.y = self.cameraView.frame.height
            
        }, completion: { (finished: Bool) in
            
            
            
        })
        
    }
    
    @objc func loadInCrate() {
        
        var count : Int = 0
        for crate in truck.crates {
            if crate.title == checkCrate.title {
                let thisCell : CrateCell = crateTableView.cellForRow(at: IndexPath(row: count, section: 0)) as! CrateCell
                thisCell.contentView.layer.opacity = 1
                thisCell.codeImage.layer.borderColor = UIColor.green.cgColor
                crateLoadedCount += 1
                
                if crateLoadedCount == truck.crates.count {
                    if truck.loaded {
                        truck.loaded = false
                    } else {
                        truck.loaded = true
                    }
                    dataHandle.saveTruck()
                    presentCompleteView()
                    
                } else {
                    dismissCrateView()
                }
                return
            }
            count += 1
        }
        
    }
    
    func presentCompleteView() {
        
        let statusBarHeight = statusBar.frame.height
        let navHeight = self.navigationController?.navigationBar.frame.height
        
        UIView.animate(withDuration: 0.35, delay: 0.2, options: .curveEaseOut, animations: {
            
            self.completedTruckView.frame.origin.y = statusBarHeight + navHeight!
            
            }, completion: {(finished: Bool) in
                self.completeButton.isEnabled = true
        })
        
    }
    
    @objc func okayButton() {
        navigationController?.pushViewController(TruckController(), animated: true)
    }
    
}




























