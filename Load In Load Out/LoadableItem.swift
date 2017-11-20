//
//  LoadableItem.swift
//  Load In Load Out
//
//  Created by Caleb Lindsey on 11/15/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class LoadableItem : NSObject, NSCoding {
    
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
        
        self.title = aDecoder.decodeObject(forKey: "loadableItemTitle") as! String
        self.setupLength = aDecoder.decodeInteger(forKey: "loadableSetupLength")
        self.setupInstructions = aDecoder.decodeObject(forKey: "loadableSetupInstructions") as! String
        
    }
    
    func initWithCoder(aDecoder: NSCoder) -> LoadableItem {
        
        self.title = aDecoder.decodeObject(forKey: "loadableItemTitle") as! String
        self.setupLength = aDecoder.decodeInteger(forKey: "loadableSetupLength")
        self.setupInstructions = aDecoder.decodeObject(forKey: "loadableSetupInstructions") as! String
        
        return self
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "loadableItemTitle")
        aCoder.encode(setupLength, forKey: "loadableSetupLength")
        aCoder.encode(setupInstructions, forKey: "loadableSetupInstructions")
        
    }
    
}
