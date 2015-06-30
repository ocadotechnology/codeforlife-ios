//
//  SubGameViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 29/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

class SubGameViewController: UIViewController {
    
    var gameViewController: GameViewController?
    
    var frame: CGRect {
        get {
            return CGRect(x: 0, y: 0, width: 0, height: 0)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        view.frame = frame
    }

}
