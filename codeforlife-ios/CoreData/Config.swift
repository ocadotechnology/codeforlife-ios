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
        guard let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else {
            return []
        }
        let fetchRequest = NSFetchRequest(entityName: "Config")
        let managedObjectContext = appDelegate.managedObjectContext
        
        do {
            if let results = try managedObjectContext?.executeFetchRequest(fetchRequest) as? [Config] {
                return results
            }
        } catch let error {
            print(error)
        }
        return []
    }
    
    class func save() {
        guard let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else {
            return
        }
        let managedObjectContext = appDelegate.managedObjectContext
        do {
            try managedObjectContext?.save()
        } catch {
            print("Cannot save episodes, error: \(error)")
        }
    }
    
    
    class func removeAllEntries() {
        guard let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else {
            return
        }
        let managedObjectContext = appDelegate.managedObjectContext
        for config in Config.fetchResults() {
            managedObjectContext?.deleteObject(config)
        }
    }

}
