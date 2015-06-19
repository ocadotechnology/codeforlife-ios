//
//  GameMenuViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 18/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

class GameViewController: UISplitViewController {
    
    var level : Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGameViews()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setMasterViewWidth(50.0)
    }
    
    private func setupGameViews() {
        if let detailViewController = self.viewControllers.last as? GameDetailViewController {
            detailViewController.level = self.level
            if let masterViewController = self.viewControllers.first as? GameMasterViewController {
                masterViewController.gameDetailViewController = detailViewController
            }
        }
    }
    
    private func setMasterViewWidth(width: Float) {
        self.setValue(NSNumber(float: width), forKey: "_masterColumnWidth")
    }

}
