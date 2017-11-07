//
//  TruckCell.swift
//  Load In Load Out
//
//  Created by Caleb Lindsey on 11/2/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class TruckCell : UITableViewCell {
    
    let truckTitleLabel : UILabel = {
        let label = UILabel()
        return label
    }()
    
    let truckImage : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(truckTitleLabel)
        self.contentView.addSubview(truckImage)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        truckImage.frame = CGRect(x: 15, y: self.frame.height / 2 - ((self.frame.height - 20) / 2), width: self.frame.height - 20, height: self.frame.height - 20)
        truckTitleLabel.frame = CGRect(x: truckImage.frame.maxX + 15, y: 0, width: self.frame.width - 15 - 15 - truckImage.frame.width, height: self.frame.height)
        
    }
    
}
