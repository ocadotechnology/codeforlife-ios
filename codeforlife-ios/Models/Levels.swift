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
    
    func addSection(section: String) -> LevelSection? {
        var newSection = LevelSection(name: section)
        if let previousSection = sections.last {
            previousSection.nextSection = newSection
            newSection.previousSection = previousSection
        }
        sections.append(newSection)
        return newSection
    }
    
    func getSection(index: Int) -> LevelSection? {
        if index < count {
            return sections[index]
        } else {
            return nil
        }
    }
    
}