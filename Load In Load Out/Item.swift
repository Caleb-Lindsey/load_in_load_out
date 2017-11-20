//
//  Item.swift
//  Load In Load Out
//
//  Created by Caleb Lindsey on 10/19/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class Item : NSObject, NSCoding {
    
    // Variable
    var title : String = String()
    var setupLength : Int = Int()
    var setupInstructions : String = String()
        
    init(title: String, setupLength: Int, setupInstructions: String) {
        self.title = title
        self.setupLength = setupLength
        self.setupInstructions = setupInstructions
    }
    
    override init() {
        self.title = ""
        self.setupLength = 0
        self.setupInstructions = ""
    }
    
    required init(coder aDecoder: NSCoder) {
        
        self.title = aDecoder.decodeObject(forKey: "itemTitle") as! String
        self.setupLength = aDecoder.decodeInteger(forKey: "setupLength")
        self.setupInstructions = aDecoder.decodeObject(forKey: "setupInstructions") as! String
        
    }
    
    func initWithCoder(aDecoder: NSCoder) -> Item {
        
        self.title = aDecoder.decodeObject(forKey: "itemTitle") as! String
        self.setupLength = aDecoder.decodeInteger(forKey: "setupLength")
        self.setupInstructions = aDecoder.decodeObject(forKey: "setupInstructions") as! String
        
        return self
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "itemTitle")
        aCoder.encode(setupLength, forKey: "setupLength")
        aCoder.encode(setupInstructions, forKey: "setupInstructions")
        
    }
    
}
