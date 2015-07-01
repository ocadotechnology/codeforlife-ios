//
//  TableViewCell.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 19/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

class LevelTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
        containerView.layer.borderWidth = 5
        containerView.layer.borderColor = kC4LEpisodeBorderColor.CGColor
        containerView.backgroundColor = kC4LEpisodeBackgroundColor
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        //        super.setSelected(selected, animated: animated)
    }

}
