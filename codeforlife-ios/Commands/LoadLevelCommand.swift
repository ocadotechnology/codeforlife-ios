//
// Created by Thomas CASSANY on 17/06/15.
// Copyright (c) 2015 Ocado. All rights reserved.
//

import Foundation

class LoadLevelCommand : Command {
    
    var level: Level;
    
    init(level: Level) {
        self.level = level;
    }

    convenience init(levelNumber: Int, description: String) {
        self.init(level: Level(number: levelNumber, description: description))
    }
    
    func execute<Level>(response: Level -> Void) {
        NSException(name: "Absract LoadLevelCommand method called", reason: "" , userInfo: nil).raise()
    }

}
