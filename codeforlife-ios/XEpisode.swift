//
//  Episode1.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 24/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation
import CoreData

@objc(XEpisode)
class XEpisode: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var url: String
    @NSManaged var id: NSNumber
    
    class func createInManagedObjectContext(id: Int, name: String, url: String) -> XEpisode {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("XEpisode", inManagedObjectContext: managedObjectContext!) as! XEpisode

        newItem.id = id
        newItem.name = name
        newItem.url = url
        
        return newItem
    }
    
    class func fetchResults() -> [XEpisode] {
        let fetchRequest = NSFetchRequest(entityName: "XEpisode")
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        
        if let fetchResults = managedObjectContext?.executeFetchRequest(fetchRequest, error: nil) as? [XEpisode] {
            return fetchResults
        }
        return []
    }
    
    class func save() {
        let fetchRequest = NSFetchRequest(entityName: "XEpisode")
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        
        var error: NSError?
        managedObjectContext?.save(&error)
        if error != nil {
            let alert = UIAlertView()
            alert.message = "Cannot Save Episodes"
            alert.dismissWithClickedButtonIndex(-1, animated: true)
            alert.show()
        }
    }
    
    class func removeAllEntries() {
        let fetchRequest = NSFetchRequest(entityName: "XEpisode")
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        
        let episodes = XEpisode.fetchResults()
        for episode in episodes {
            managedObjectContext?.deleteObject(episode)
        }
        
        
        
    }

}
