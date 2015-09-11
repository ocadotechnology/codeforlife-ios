//
//  EpisodeViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 01/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

public class EpisodeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let TableViewAccessibilityLabel = "EpisodeList"
    let CellReuseIdentifier = "Episode"
    let SegueIdentifier = "FetchLevelsAction"
    
    @IBOutlet weak var tableView: UITableView!
    
    var episodes = [Episode]() {
        didSet {
            tableView.reloadData()
        }
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        tableView.accessibilityIdentifier = TableViewAccessibilityLabel
        tableView.delegate = self
        tableView.dataSource = self
        FetchEpisodesFromCoreData()
    }
    
    private func FetchEpisodesFromCoreData() {
        episodes = Episode.fetchResults().sorted({$0.id < $1.id}).filter({$0.id <= 2})
        println("\(episodes.count) episodes in total")
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellReuseIdentifier, forIndexPath: indexPath) as! EpisodeTableViewCell
        var episode = episodes[indexPath.row]
        cell.titleLabel.text = "Episode \(indexPath.row+1) : \(episode.name)"
        return cell
    }
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier(SegueIdentifier, sender: self)
    }
    
    override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let controller = segue.destinationViewController as? LevelTableViewController {
            if let identifier = segue.identifier {
                switch identifier {
                case SegueIdentifier:
                    var indexPath = tableView.indexPathForSelectedRow()!
                    controller.index = indexPath.row + 1
                default: break
                }
            }
        }
    }
    
    @IBAction func unwindToEpisodeViewController(segue: UIStoryboardSegue) {}

}
