//
//  DecorationType.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 28/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation
import CoreData

@objc(DecorationType)
class DecorationType: NSManagedObject {

    @NSManaged var id: NSNumber
    @NSManaged var name: String
    @NSManaged var url: String
    @NSManaged var width: NSNumber
    @NSManaged var height: NSNumber
    @NSManaged var z_index: NSNumber
    @NSManaged var theme: NSNumber

}
