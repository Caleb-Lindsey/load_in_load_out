//
//  CustomTextView.swift
//  Load In Load Out
//
//  Created by Caleb Lindsey on 11/15/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class CustomTextView : UITextView {
    
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 30))
    
    init() {
        super.init(frame: CGRect(), textContainer: nil)
        self.backgroundColor = GlobalVariables.grayColor
        self.returnKeyType = UIReturnKeyType.done
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
