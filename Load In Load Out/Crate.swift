//
//  Crate.swift
//  Load In Load Out
//
//  Created by Caleb Lindsey on 10/19/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class Crate : NSObject, NSCoding {
    
    // Variables
    var title : String = String()
    var items : [Item] = [Item]()
    var type : String = String()
    var code : UIImage = UIImage()
    var location : Int = Int()
    
    override init() {
        self.title = ""
        self.items = []
        self.type = ""
        self.code = UIImage()
        self.location = -1
    }
    
    init(title: String, items: [Item], type: String, code: UIImage, location: Int) {
        self.title = title
        self.items = items
        self.type = type
        self.code = code
        self.location = location
    }
    
    required init(coder aDecoder: NSCoder) {
        
        self.title = aDecoder.decodeObject(forKey: "crateTitle") as! String
        self.items = aDecoder.decodeObject(forKey: "items") as! [Item]
        self.type = aDecoder.decodeObject(forKey: "type") as! String
        self.code = aDecoder.decodeObject(forKey: "code") as! UIImage
        self.location = aDecoder.decodeObject(forKey: "location") as! Int

        
    }
    
    func initWithCoder(aDecoder: NSCoder) -> Crate {
        
        self.title = aDecoder.decodeObject(forKey: "crateTitle") as! String
        self.items = aDecoder.decodeObject(forKey: "items") as! [Item]
        self.type = aDecoder.decodeObject(forKey: "type") as! String
        self.code = aDecoder.decodeObject(forKey: "code") as! UIImage
        self.location = aDecoder.decodeObject(forKey: "location") as! Int
        
        return self
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "crateTitle")
        aCoder.encode(items, forKey: "items")
        aCoder.encode(type, forKey: "type")
        aCoder.encode(code, forKey: "code")
        aCoder.encode(location, forKey: "location")
        
    }
    
}





















