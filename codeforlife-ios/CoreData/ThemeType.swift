//
//  ThemeType.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 28/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation
import CoreData

// Not in use
@objc(ThemeType)
class ThemeType: NSManagedObject {

    @NSManaged var url: String
    @NSManaged var name: String
    @NSManaged var background: String
    @NSManaged var border: String
    @NSManaged var selected: String

}
