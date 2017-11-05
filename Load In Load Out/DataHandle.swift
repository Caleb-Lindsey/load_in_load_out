//
//  DataHandle.swift
//  Load In Load Out
//
//  Created by Caleb Lindsey on 10/17/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

struct GlobalVariables {
    static var grayColor : UIColor = UIColor(red: 35/255, green: 35/255, blue: 35/255, alpha: 1)
    static var yellowColor : UIColor = UIColor(red: 254/255, green: 203/255, blue: 80/255, alpha: 1)
    static var yellowForTintColor : UIColor = UIColor(red: 235/255, green: 180/255, blue: 15/255, alpha: 1)
    static var redColor : UIColor = UIColor(red: 154/255, green: 53/255, blue: 19/255, alpha: 1)
    
    static var arrayOfTrucks : [Truck] = [Truck]()
    static var arrayOfCrates : [Crate] = [Crate]()
    static var arrayOfItems : [Item] = [Item]()
    static var arrayOfTypes : [String] = ["Lighting", "Band", "Stage", "Audio", "Visual"]
    static var arrayOfLocations : [Int] = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
    
}

class DataHandle {
    
    var longDescription : String = "Facts of Sin\n1) Creation declares it\n- Something is wrong\n2) Human logic declares it\n- Something is wrong inside of man\n- Romans 7:14-21\n- Man goes wrong because he is wrong\n3) Human history declares it\n- James 4:1-44) Romans 2:14-15 \n- Human conscience declares it\n5) Human experience declares it\n6) Human religions declare it\n7) Believers declare it\n8) Scriptures declare it"
    
    func mockDataFill() {
        
        print("Filling Mock Data...")
        let item1 : Item = Item(title: "Camera Lens", setupLength: 0, setupInstructions: longDescription)
        let item2 : Item = Item(title: "Production Camera", setupLength: 5, setupInstructions: "No setup required.")
        let item3 : Item = Item(title: "Tripod", setupLength: 10, setupInstructions: "No setup required.")
        let item4 : Item = Item(title: "Amp", setupLength: 10, setupInstructions: "Plug it in and jam out.")
        let item5 : Item = Item(title: "Camera Jib", setupLength: 15, setupInstructions: "This might take awhile.")
        let item6 : Item = Item(title: "Microphone", setupLength: 3, setupInstructions: "Place in center stage.")
        let item7 : Item = Item(title: "Light Board", setupLength: 10, setupInstructions: "Plug it in and check presets.")
        let item8 : Item = Item(title: "Bass Drum", setupLength: 10, setupInstructions: "Lay down and hook up pedal.")
        let item9 : Item = Item(title: "Left Metal Strut", setupLength: 10, setupInstructions: "You need a wrench.")
        let item10 : Item = Item(title: "Right Metal Strut", setupLength: 10, setupInstructions: "You need a wrench.")

        let crate1 : Crate = Crate(title: "Stage Crate 1", items: [item1, item2, item3], type: "Audio", code: UIImage(named: "QRCode")!, location: 1)
        let crate2 : Crate = Crate(title: "Stage Crate 2", items: [item4, item5, item6], type: "Band", code: UIImage(named: "QRCode")!, location: 2)
        let crate3 : Crate = Crate(title: "Stage Crate 3", items: [item7, item4, item1, item10], type: "Stage", code: UIImage(named: "QRCode")!, location: 8)
        let crate4 : Crate = Crate(title: "Floor Crate 1", items: [item5, item8, item9, item2], type: "Lighting", code: UIImage(named: "QRCode")!, location: 4)
        let crate5 : Crate = Crate(title: "Floor Crate 2", items: [item3, item8, item6, item10], type: "Visual", code: UIImage(named: "QRCode")!, location: 1)
        
        let truck1 : Truck = Truck(title: "Church At The Dunk", captain: "Caleb Lindsey", crates: [crate1, crate2, crate3], date: Date(), notes: "This is a big truck.", loaded: true)
        let truck2 : Truck = Truck(title: "Christmas At The Dunk", captain: "Ellie Granata", crates: [crate1, crate2, crate3, crate4, crate5], date: Date(), notes: "This is my favorite truck.", loaded: false)
        let truck3 : Truck = Truck(title: "CATD: New Years!", captain: "Danielle Florent", crates: [crate4, crate5, crate2], date: Date(), notes: "This is a small truck.", loaded: false)
        
        GlobalVariables.arrayOfItems = [item1, item2, item3, item4, item5, item6, item7, item8, item9, item10]
        GlobalVariables.arrayOfCrates = [crate1, crate2, crate3, crate4, crate5]
        GlobalVariables.arrayOfTrucks = [truck1, truck2, truck3]
        print("Complete.")


    }
    
    func fillItemData() {
        
        print("Filling Items")
        if let data = UserDefaults.standard.object(forKey: "ItemList") as? NSData {
            GlobalVariables.arrayOfItems = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! [Item]
        }
        
    }
    
    func fillCrateData() {
        
        print("Filling Crates")
        if let data = UserDefaults.standard.object(forKey: "CrateList") as? NSData {
            GlobalVariables.arrayOfCrates = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! [Crate]
        }
        
    }
    
    func fillTruckData() {
        
        print("Filling Trucks")
        if let data = UserDefaults.standard.object(forKey: "TruckList") as? NSData {
            GlobalVariables.arrayOfTrucks = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! [Truck]
        }
        
    }
    
    func saveItem() {
        
        let data = NSKeyedArchiver.archivedData(withRootObject: GlobalVariables.arrayOfItems)
        UserDefaults.standard.set(data, forKey: "ItemList")
        print("Items Saved")
        
    }
    
    func saveCrate() {
        
        let data = NSKeyedArchiver.archivedData(withRootObject: GlobalVariables.arrayOfCrates)
        UserDefaults.standard.set(data, forKey: "CrateList")
        print("Crates Saved")
        
    }
    
    func saveTruck() {
        
        let data = NSKeyedArchiver.archivedData(withRootObject: GlobalVariables.arrayOfTrucks)
        UserDefaults.standard.set(data, forKey: "TruckList")
        print("Trucks Saved")
        
    }
    
}






































