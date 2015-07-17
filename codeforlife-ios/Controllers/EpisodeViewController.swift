//
//  EpisodeViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 01/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let CellReuseIdentifier = "Episode"
    let SegueIdentifier = "FetchLevelsAction"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var episodes = [Episode]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        FetchEpisodesRequest(self).execute {
            activityIndicator?.stopAnimating()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellReuseIdentifier, forIndexPath: indexPath) as! EpisodeTableViewCell
        var episode = episodes[indexPath.row]
        cell.titleLabel.text = "Episode \(indexPath.row+1) : \(episode.name)"
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier(SegueIdentifier, sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let controller = segue.destinationViewController as? LevelTableViewController {
            if let identifier = segue.identifier {
                switch identifier {
                case SegueIdentifier:
                    var indexPath = tableView.indexPathForSelectedRow()!
                    controller.requestedEpisode = episodes[indexPath.row]
                default: break
                }
            }
        }
    }
    
    @IBAction func unwindToEpisodeViewController(segue: UIStoryboardSegue) {}

}
