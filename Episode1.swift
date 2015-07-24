//
//  Episode1.swift
//  
//
//  Created by Joey Chan on 24/07/2015.
//
//

import Foundation
import CoreData

class Episode1: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var url: String
    @NSManaged var nextEpisode: Episode?

}
