//
//  Truck.swift
//  Load In Load Out
//
//  Created by Caleb Lindsey on 10/19/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class Truck {
    
    // Variables
    var title : String = String()
    var captain : String = String()
    var crates : [Crate] = [Crate]()
    var date : Date = Date()
    var notes : String = String()
    var loaded : Bool = false
    
    init(title: String, captain: String, crates: [Crate], date: Date, notes: String, loaded: Bool) {
        self.title = title
        self.captain = captain
        self.crates = crates
        self.date = date
        self.notes = notes
        self.loaded = loaded
    }
    
}
