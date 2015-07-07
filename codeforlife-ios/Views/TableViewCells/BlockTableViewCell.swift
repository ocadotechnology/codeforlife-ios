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
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
//        super.setHighlighted(highlighted, animated: animated)
    }

}
