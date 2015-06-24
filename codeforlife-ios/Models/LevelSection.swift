//
//  LevelSection.swift
//  Pods
//
//  Created by Joey Chan on 20/06/2015.
//
//

import Foundation

class LevelSection {
    
    var name : String?
    var count: Int {
        return levels.count
    }
    var nextSection: LevelSection?
    var previousSection: LevelSection?
    var levels = [Level]()
    
    init(name: String) {
        self.name = name
    }
    
    func addLevel(level: Level) {
        if let previousLevel = levels.last {
            previousLevel.nextLevel = level
        } else if let lastLevelInPreviousSection = self.previousSection?.getLastLevel() {
            lastLevelInPreviousSection.nextLevel = level
        }
        levels.append(level)
    }
    
    func getLevel(index: Int) ->  Level? {
        if (index < count) {
            return levels[index]
        } else {
            return nil
        }
    }
    
    func clear() {
        levels = [Level]()
    }
    
    func getLastLevel() -> Level? {
        return levels.last
    }
    
}
