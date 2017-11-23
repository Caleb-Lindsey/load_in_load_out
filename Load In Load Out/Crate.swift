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
        self.location = aDecoder.decodeInteger(forKey: "location")
        
    }
    
    func initWithCoder(aDecoder: NSCoder) -> Crate {
        
        self.title = aDecoder.decodeObject(forKey: "crateTitle") as! String
        self.items = aDecoder.decodeObject(forKey: "items") as! [Item]
        self.type = aDecoder.decodeObject(forKey: "type") as! String
        self.code = aDecoder.decodeObject(forKey: "code") as! UIImage
        self.location = aDecoder.decodeInteger(forKey: "location")
        
        return self
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "crateTitle")
        aCoder.encode(items, forKey: "items")
        aCoder.encode(type, forKey: "type")
        aCoder.encode(code, forKey: "code")
        aCoder.encode(location, forKey: "location")
        
    }
    
    func typeIcon() -> UIImage {
        
        var image : UIImage = UIImage()
        
        switch self.type {
        case GlobalVariables.arrayOfTypes[0]: // Visuals
            image = UIImage(named: "Visuals")!
        case GlobalVariables.arrayOfTypes[1]: // Lighting
            image = UIImage(named: "Lighting")!
        case GlobalVariables.arrayOfTypes[2]: // Audio
            image = UIImage(named: "Audio")!
        case GlobalVariables.arrayOfTypes[3]: // Stage
            image = UIImage(named: "Stage")!
        case GlobalVariables.arrayOfTypes[4]: // TV
            image = UIImage(named: "TV")!
        case GlobalVariables.arrayOfTypes[5]: // Band
            image = UIImage(named: "Band")!
        case GlobalVariables.arrayOfTypes[6]: // Misc
            image = UIImage(named: "Misc")!
        default:
            image = UIImage(named: "")! // ERROR
        }
        
        return image
        
    }
    
}





















