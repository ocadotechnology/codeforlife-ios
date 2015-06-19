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

        if let detailViewController = self.viewControllers.last as? GameDetailViewController {
            detailViewController.level = self.level
            if let masterViewController = self.viewControllers.first as? GameMasterViewController {
                masterViewController.gameDetailViewController = detailViewController
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
