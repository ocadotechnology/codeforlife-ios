//
//  LevelTableViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 18/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

public class LevelTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let SegueIdentifier = "LoadLevel"
    let CellReuseIdentifier = "Level"
    let TableViewAccessibilityIdentifier = "LevelList"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var prevEpisodeButton: UIButton!
    @IBOutlet weak var nextEpisodeButton: UIButton!
    
    var index = 0 {
        didSet {
            if isViewLoaded() && index <= 2{
                loadEpisode(self.index)
            }
        }
    }
    
    var levels = [Level]() {
        didSet {
            self.tableView.reloadData()
        }
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        tableView.accessibilityIdentifier = TableViewAccessibilityIdentifier
        tableView.delegate = self
        tableView.dataSource = self
        loadEpisode(self.index)
    }
        
    private func loadEpisode(index: Int) {
        let episodes = Episode.fetchResults().sorted({$0.id < $1.id})
        let episodeUrl = episodes[index-1].url
        levels = Level.fetchResults()
                        .filter({[unowned self] in $0.episodeUrl == episodeUrl})
            .sorted({$0.level < $1.level})
        println("\(levels.count) levels in Episode \(index)")
        prevEpisodeButton.hidden = index == 1
        nextEpisodeButton.hidden = index == 2
        self.titleLabel.text = Episode.fetchResults().filter({$0.id == self.index})[0].name
    }

    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return levels.count
    }
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier(SegueIdentifier, sender: self)
    }


    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellReuseIdentifier, forIndexPath: indexPath) as! LevelTableViewCell
        let level = levels[indexPath.row]
        cell.numberLabel.text =  "Level " + level.name
        cell.descriptionLabel.text = level.title
        return cell
    }

    override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let gameViewController = segue.destinationViewController as? GameViewController {
            if let identifier = segue.identifier {
                switch identifier {
                    case SegueIdentifier:
                        let indexPath = tableView.indexPathForSelectedRow()!
                        let level = levels[indexPath.row]
                        gameViewController.levelUrl = level.url
                    default: break
                }
            }
        }
    }
    
    @IBAction func gotoPreviousEpisode() { index-- }
    @IBAction func gotoNextEpisode() { index++ }
    @IBAction func unwindToLevelTableView(segue: UIStoryboardSegue) {}

}
