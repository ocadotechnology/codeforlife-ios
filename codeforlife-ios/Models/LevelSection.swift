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
    var levels = [Level]()
    
    init(name: String) {
        self.name = name
    }
    
    func addLevel(level: Level) {
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
    
}
