//
//  LevelTableViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 18/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

class LevelTableViewController: UITableViewController {
    
    let kCFLLoadLevelSegueIdentifier = "LoadLevel"
    
    var levels = [[Level]]() {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.levels = fetchLevels()
        
    }
    
    func fetchLevels() -> [[Level]] {
        return [[Level(number: 1),Level(number: 2),Level(number: 3)],[Level(number: 4), Level(number: 5), Level(number: 6)]]
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return levels.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return levels[section].count
    }

    private struct Storyboard {
        static let CellReuseIdentifier = "Level"
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath) as! UITableViewCell

        let level = levels[indexPath.section][indexPath.row]
        cell.textLabel!.text = "Level \(level.number)"

        return cell
    }



    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let wvc = segue.destinationViewController as? GameViewController {
            if let identifier = segue.identifier {
                switch identifier {
                case kCFLLoadLevelSegueIdentifier:
                    var indexPath = tableView.indexPathForSelectedRow()!
                    var level = levels[indexPath.section][indexPath.row]
                    wvc.level = level.number
                default: break
                }
            }
        }

    }


}
