//
//  BlockType.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 28/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation
import CoreData

@objc(BlockType)
class BlockType: NSManagedObject {

    @NSManaged var url: String
    @NSManaged var id: NSNumber
    @NSManaged var type: String

}
