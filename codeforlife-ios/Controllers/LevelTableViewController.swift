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
    let CellReuseIdentifier = "Level"
    
    var levels = Levels() {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        FetchLevelsAction(viewController: self).execute()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return levels.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return levels.sections[section].count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var indexPath = tableView.indexPathForSelectedRow()!
        var level = levels.sections[indexPath.section].levels[indexPath.row]
        performSegueWithIdentifier(kCFLLoadLevelSegueIdentifier, sender: self)
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellReuseIdentifier, forIndexPath: indexPath) as! LevelTableViewCell
        var level = levels.sections[indexPath.section].levels[indexPath.row]
        cell.numberLabel.text =  "Level \(level.number)"
        cell.descriptionLabel.text = level.description
        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let gameViewController = segue.destinationViewController as? GameViewController {
            if let identifier = segue.identifier {
                switch identifier {
                    case kCFLLoadLevelSegueIdentifier:
                        var indexPath = tableView.indexPathForSelectedRow()!
                        if let section = levels.getSection(indexPath.section) {
                            if let level = section.getLevel(indexPath.row) {
                                gameViewController.level = level
                            }
                        }
                    default: break
                }
            }
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section + 1) : \(levels.getSection(section)!.name!)"
    }
    
    @IBAction func unwindToLevelTableView(segue: UIStoryboardSegue) {
        
    }

}
