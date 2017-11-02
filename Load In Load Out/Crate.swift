//
//  Crate.swift
//  Load In Load Out
//
//  Created by Caleb Lindsey on 10/19/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class Crate {
    
    // Variables
    var title : String = String()
    var items : [Item] = [Item]()
    var type : String = String()
    var code : UIImage = UIImage()
    var location : Int = Int()
    
    init() {
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
    
}
