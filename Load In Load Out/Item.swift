//
//  Item.swift
//  Load In Load Out
//
//  Created by Caleb Lindsey on 10/19/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class Item {
    
    // Variable
    var title : String = String()
    var setupLength : Int = Int()
    var setupInstructions : String = String()
    
    init(title: String, setupLength: Int, setupInstructions: String) {
        self.title = title
        self.setupLength = setupLength
        self.setupInstructions = setupInstructions
    }
    
}
