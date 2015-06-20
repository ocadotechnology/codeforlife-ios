//
//  Levels.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 20/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class Levels {
    
    var count: Int {
        return sections.count
    }
    
    var sections = [LevelSection]()
    
    init() {}
    
    func addSection(section: String) {
        sections.append(LevelSection(name: section))
    }
    
    func getSection(index: Int) -> LevelSection? {
        if index < count {
            return sections[index]
        } else {
            return nil
        }
    }
    
}