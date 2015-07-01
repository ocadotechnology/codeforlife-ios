//
//  LevelTableViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 18/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

class LevelTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let kCFLLoadLevelSegueIdentifier = "LoadLevel"
    let CellReuseIdentifier = "Level"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var requestedEpisode: Episode?
    
    var episode : Episode? {
        didSet {
            if isViewLoaded() {
                FetchLevelsAction(viewController: self, url: episode!.url).switchToDev().execute {
                    activityIndicator?.stopAnimating()
                }
            }
        }
    }
    
    var levels = [Level]() {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        episode = requestedEpisode!
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return levels.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var indexPath = tableView.indexPathForSelectedRow()!
        var level = levels[indexPath.row]
        performSegueWithIdentifier(kCFLLoadLevelSegueIdentifier, sender: self)
    }


    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellReuseIdentifier, forIndexPath: indexPath) as! LevelTableViewCell
        var level = levels[indexPath.row]
        cell.numberLabel.text =  "Level \(indexPath.row+1)"
        cell.descriptionLabel.text = level.title
        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let gameViewController = segue.destinationViewController as? GameViewController {
            if let identifier = segue.identifier {
                switch identifier {
                    case kCFLLoadLevelSegueIdentifier:
                        var indexPath = tableView.indexPathForSelectedRow()!
                        gameViewController.level = levels[indexPath.row]
                    default: break
                }
            }
        }
    }
    
    @IBAction func unwindToLevelTableView(segue: UIStoryboardSegue) {}

}
