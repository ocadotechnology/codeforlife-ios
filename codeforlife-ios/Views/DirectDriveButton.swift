//
//  DirectDriveButton.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 26/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

class DirectDriveButton: UIButton {

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }

}
