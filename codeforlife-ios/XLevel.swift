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

    @NSManaged var name: String
    @NSManaged var title: String
    @NSManaged var url: String
    @NSManaged var webViewUrl: String
    @NSManaged var blockSetUrl: String
    @NSManaged var mapUrl: String
    @NSManaged var levelDescription: String
    @NSManaged var hint: String
    @NSManaged var pythonEnabled: NSNumber
    @NSManaged var pythonViewEnabled: NSNumber
    
    class func createInManagedObjectContext(episode: Int, level: Int, name: String, title: String, url: String, levelDescription: String, hint: String, blockSetUrl: String, pythonEnabled: Bool, pythonViewEnabled: Bool, webViewUrl: String, mapUrl: String) -> XLevel {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("XLevel", inManagedObjectContext: managedObjectContext!) as! XLevel
        
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

}
