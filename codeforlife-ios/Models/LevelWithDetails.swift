//
//  LevelWithDetails.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 03/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class LevelWithDetails: Level {
    
    
    init(url: String, name: String, title: String, description: String, hint: String, blocklyEnabled: Bool, pythonEnabled: Bool, pythonViewEnabled: Bool){
        super.init(url: url, name: name, title: title)
    }
    
    
}