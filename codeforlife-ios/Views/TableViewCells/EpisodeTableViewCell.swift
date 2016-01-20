//
//  EpisodeTableViewCell.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 01/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func setSelected(selected: Bool, animated: Bool) {
        
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
        containerView.layer.borderWidth = 5
        containerView.layer.borderColor = kC4LEpisodeBorderColor.CGColor
        containerView.backgroundColor = kC4LEpisodeBackgroundColor
    }

}
