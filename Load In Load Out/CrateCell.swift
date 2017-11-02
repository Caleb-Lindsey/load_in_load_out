//
//  CrateCell.swift
//  Load In Load Out
//
//  Created by Caleb Lindsey on 11/2/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class CrateCell : UITableViewCell {
    
    let crateTitleLabel : UILabel = {
        let label = UILabel()
        return label
    }()
    
    let codeImage : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(crateTitleLabel)
        self.contentView.addSubview(codeImage)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        codeImage.frame = CGRect(x: 15, y: self.frame.height / 2 - ((self.frame.height - 20) / 2), width: self.frame.height - 20, height: self.frame.height - 20)
        crateTitleLabel.frame = CGRect(x: codeImage.frame.maxX + 15, y: 0, width: self.frame.width, height: self.frame.height)
        
    }
    
}
