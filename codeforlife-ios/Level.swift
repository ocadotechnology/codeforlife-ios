//
//  Level.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 24/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation
import CoreData

@objc(Level)
class Level: NSManagedObject {
    
    @NSManaged var episodeUrl: String
    @NSManaged var level: NSNumber
    @NSManaged var name: String
    @NSManaged var title: String
    @NSManaged var url: String
    @NSManaged var webViewUrl: String
    @NSManaged var blockSetUrl: String
    @NSManaged var mapUrl: String
    @NSManaged var levelDescription: String
    @NSManaged var hint: String
    @NSManaged var blocklyEnabled: NSNumber
    @NSManaged var pythonEnabled: NSNumber
    @NSManaged var pythonViewEnabled: NSNumber
    @NSManaged var nextLevelUrl: String
    
    class func createInManagedObjectContext(episodeUrl: String, level: Int, name: String, title: String, url: String, levelDescription: String, hint: String, blockSetUrl: String, blocklyEnabled: Bool, pythonEnabled: Bool, pythonViewEnabled: Bool, webViewUrl: String, mapUrl: String, nextLevelUrl: String) -> Level {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Level", inManagedObjectContext: managedObjectContext!) as! Level
        newItem.episodeUrl = episodeUrl
        newItem.level = level
        newItem.name = name
        newItem.title = title
        newItem.url = url
        newItem.levelDescription = levelDescription
        newItem.hint = hint
        newItem.blockSetUrl = blockSetUrl
        newItem.pythonEnabled = pythonEnabled
        newItem.pythonViewEnabled = pythonViewEnabled
        newItem.webViewUrl = webViewUrl
        newItem.mapUrl = mapUrl
        newItem.nextLevelUrl = nextLevelUrl
        return newItem
    }
    
    class func fetchResults() -> [Level] {
        let fetchRequest = NSFetchRequest(entityName: "Level")
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        let fetchResults = managedObjectContext?.executeFetchRequest(fetchRequest, error: nil) as? [Level]
        return fetchResults ?? []
    }
    
    class func save() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        var error: NSError?
        managedObjectContext?.save(&error)
        if error != nil { println("Error: Cannot save levels") }
    }
    
    class func removeAllEntries() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        for episode in Level.fetchResults() {
            managedObjectContext?.deleteObject(episode)
        }
    }

}
