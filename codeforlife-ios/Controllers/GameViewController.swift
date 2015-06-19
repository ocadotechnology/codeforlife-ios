//
//  GameMenuViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 18/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

class GameViewController: UISplitViewController {
    
    let MasterViewWidth = 70.0 as Float
    
    var level : Level?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGameViews()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setMasterViewWidth(MasterViewWidth)
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
    
    func loadGameRequest(request: NSURLRequest) {
        if let detailViewController = self.viewControllers.last as? GameDetailViewController {
            detailViewController.webView?.loadRequest(request)
        }
    }

}
