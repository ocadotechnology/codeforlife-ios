//
//  XLevel.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 24/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation
import CoreData

@objc(XLevel)
class XLevel: NSManagedObject {
    
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
    
    class func createInManagedObjectContext(episodeUrl: String, level: Int, name: String, title: String, url: String, levelDescription: String, hint: String, blockSetUrl: String, blocklyEnabled: Bool, pythonEnabled: Bool, pythonViewEnabled: Bool, webViewUrl: String, mapUrl: String) -> XLevel {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("XLevel", inManagedObjectContext: managedObjectContext!) as! XLevel
        
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
        
        return newItem
    }
    
    class func fetchResults() -> [XLevel] {
        
        let fetchRequest = NSFetchRequest(entityName: "XLevel")
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        
        if let fetchResults = managedObjectContext?.executeFetchRequest(fetchRequest, error: nil) as? [XLevel] {
            return fetchResults
        }
        return []
    }
    
    class func save() {
        
        let fetchRequest = NSFetchRequest(entityName: "XLevel")
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        
        var error: NSError?
        managedObjectContext?.save(&error)
        if error != nil { println("Error: Cannot save levels") }
    }
    
    class func removeAllEntries() {
        
        let fetchRequest = NSFetchRequest(entityName: "XLevel")
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        
        let episodes = XLevel.fetchResults()
        for episode in episodes {
            managedObjectContext?.deleteObject(episode)
        }
    }
    
    func toLevel() -> Level {
        let level = Level(url: url, name: name, title: title)
        level.description = levelDescription
        level.hint = hint
        level.blockSetUrl = blockSetUrl
        level.mapUrl = mapUrl
        level.webViewUrl = webViewUrl
        level.blocklyEnabled = Bool(blocklyEnabled)
        level.pythonEnabled = Bool(pythonEnabled)
        level.pythonViewEnabled = Bool(pythonViewEnabled)
        return level
    }

}
