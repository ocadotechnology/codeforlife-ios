//
//  SubGameViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 29/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

class SubGameViewController: UIViewController {

    unowned var gameViewController: GameViewController {
        return parentViewController! as! GameViewController
    }
    
}