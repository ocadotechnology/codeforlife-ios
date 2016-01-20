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

@objc(Episode)
class Episode: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var url: String
    @NSManaged var id: NSNumber
    
    class func createInManagedObjectContext(id: Int, name: String, url: String) -> Episode {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Episode", inManagedObjectContext: managedObjectContext!) as! Episode
        newItem.id = id
        newItem.name = name
        newItem.url = url
        return newItem
    }
    
    class func fetchResults() -> [Episode] {
        let fetchRequest = NSFetchRequest(entityName: "Episode")
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        let fetchResults = try! managedObjectContext?.executeFetchRequest(fetchRequest) as? [Episode]
        return fetchResults ?? []
    }
    
    class func save() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        try! managedObjectContext?.save()
//        if error != nil { println("Cannot save episodes") }
    }
    
    class func removeAllEntries() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        for episode in Episode.fetchResults() {
            managedObjectContext?.deleteObject(episode)
        }
    }

}
