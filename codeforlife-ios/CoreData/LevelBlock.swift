//
//  LevelBlock.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 28/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation
import CoreData

// Not in use
@objc(LevelBlock)
class LevelBlock: NSManagedObject {

    @NSManaged var id: NSNumber
    @NSManaged var number: NSNumber
    @NSManaged var type: NSNumber
    @NSManaged var level: NSNumber

}
