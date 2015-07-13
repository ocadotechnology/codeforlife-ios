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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var prevEpisodeButton: UIButton!
    @IBOutlet weak var nextEpisodeButton: UIButton!
    
    weak var requestedEpisode: Episode?
    
    var episode : Episode? {
        didSet {
            if isViewLoaded() {
                prevEpisodeButton.hidden = episode?.prevEpisode == nil ? true : false
                nextEpisodeButton.hidden = episode?.nextEpisode == nil ? true : false
                activityIndicator.startAnimating()
                FetchLevelsAction(self, episode!.url).execute {
                    self.activityIndicator?.stopAnimating()
                    self.titleLabel.text = self.episode?.name
                }
            }
        }
    }
    
    var levels = [Level]() {
        didSet {
            if isViewLoaded() {
                self.tableView.reloadData()
            }
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
        cell.numberLabel.text =  "Level " + level.name
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
    
    @IBAction func gotoPreviousEpisode() {
        if let previousEpisode = episode?.prevEpisode {
            episode = previousEpisode
        }
    }
    
    @IBAction func gotoNextEpisode() {
        if let nextEpisode = episode?.nextEpisode {
            episode = nextEpisode
        }
    }
    
    
    @IBAction func unwindToLevelTableView(segue: UIStoryboardSegue) {
        SharedContext.MainGameViewController = nil
    }

}
