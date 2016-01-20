//
//  Config.swift
//  
//
//  Created by Joey Chan on 22/09/2015.
//
//

import UIKit
import Foundation
import CoreData

@objc(Config)
class Config: NSManagedObject {

    @NSManaged var eTag: String
    
    class func createInManagedObjectContext(eTag: String) -> Config {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Config", inManagedObjectContext: managedObjectContext!) as! Config
        newItem.eTag = eTag
        return newItem
    }
    
    class func fetchResults() -> [Config] {
        let fetchRequest = NSFetchRequest(entityName: "Config")
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        let fetchResults = try! managedObjectContext?.executeFetchRequest(fetchRequest) as? [Config]
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
        for config in Config.fetchResults() {
            managedObjectContext?.deleteObject(config)
        }
    }

}
