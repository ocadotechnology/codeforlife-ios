//
// Created by Thomas CASSANY on 17/06/15.
// Copyright (c) 2015 Ocado. All rights reserved.
//

import Foundation

class LoadLevelCommand : Command {
    var level: Level;

    convenience init() {
       self.init(levelNumber: 0)
    }

    init(levelNumber: Int) {
        self.level = Level(number: levelNumber)
    }
    
    func execute<Level>(response: Level -> Void) {
        NSException(name: "Absract LoadLevelCommand method called", reason: "" , userInfo: nil).raise()
    }
}
