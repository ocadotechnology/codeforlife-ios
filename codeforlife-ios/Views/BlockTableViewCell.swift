//
//  BlockTableViewCell.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 25/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

class BlockTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var stepNumber: UILabel!
    @IBOutlet weak var blockDescription: UILabel!
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        containerView.backgroundColor = UIColor(red: 0/255.0, green: 192/255.0, blue: 176/255.0, alpha: 1)
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
//        containerView.layer.borderColor = UIColor(red: 0/255.0, green: 128/255.0, blue: 160/255.0, alpha: 1).CGColor
    }
}
