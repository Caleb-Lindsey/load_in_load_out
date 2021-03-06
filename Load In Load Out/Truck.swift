//
//  Truck.swift
//  Load In Load Out
//
//  Created by Caleb Lindsey on 10/19/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class Truck : NSObject, NSCoding {
    
    // Variables
    var title : String = String()
    var captain : String = String()
    var crates : [Crate] = [Crate]()
    var loadables : [LoadableItem] = [LoadableItem]()
    var date : Date = Date()
    var notes : String = String()
    var loaded : Bool = false
    
    init(title: String, captain: String, crates: [Crate], loadables: [LoadableItem], date: Date, notes: String, loaded: Bool) {
        self.title = title
        self.captain = captain
        self.crates = crates
        self.loadables = loadables
        self.date = date
        self.notes = notes
        self.loaded = loaded
    }
    
    required init(coder aDecoder: NSCoder) {
        
        self.title = aDecoder.decodeObject(forKey: "title") as! String
        self.captain = aDecoder.decodeObject(forKey: "captain") as! String
        self.crates = aDecoder.decodeObject(forKey: "crates") as! [Crate]
        self.loadables = aDecoder.decodeObject(forKey: "loadables") as! [LoadableItem]
        self.date = aDecoder.decodeObject(forKey: "date") as! Date
        self.notes = aDecoder.decodeObject(forKey: "notes") as! String
        self.loaded = aDecoder.decodeBool(forKey: "loaded")
        
    }
    
    func initWithCoder(aDecoder: NSCoder) -> Truck {
        
        self.title = aDecoder.decodeObject(forKey: "title") as! String
        self.captain = aDecoder.decodeObject(forKey: "captain") as! String
        self.crates = aDecoder.decodeObject(forKey: "crates") as! [Crate]
        self.loadables = aDecoder.decodeObject(forKey: "loadables") as! [LoadableItem]
        self.date = aDecoder.decodeObject(forKey: "date") as! Date
        self.notes = aDecoder.decodeObject(forKey: "notes") as! String
        self.loaded = aDecoder.decodeBool(forKey: "loaded")
        
        return self
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(captain, forKey: "captain")
        aCoder.encode(crates, forKey: "crates")
        aCoder.encode(loadables, forKey: "loadables")
        aCoder.encode(date, forKey: "date")
        aCoder.encode(notes, forKey: "notes")
        aCoder.encode(loaded, forKey: "loaded")
        
    }
    
}

















